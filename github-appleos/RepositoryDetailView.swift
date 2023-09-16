import Foundation
import SwiftUI

struct RepositoryDetailView: View {
    let repo: Repository
    @State private var imageURLs: [URL]? = nil
    
    var body: some View {
        List {
            Section(header: Text("Details")) {
                Text("Name: \(repo.name)")
                Text("Description: \(repo.description ?? "No description")")
                Text("Full Name: \(repo.fullName)")
                Text("Visibility: \(repo.visibility)")
                Text("Forks: \(repo.forks)")
                Text("Watchers: \(repo.watchers)")
                Text("Open Issues: \(repo.openIssues)")
                Text("Default Branch: \(repo.defaultBranch)")
            }
            
            Section(header: Text("Owner Info")) {
                Text("Owner Login: \(repo.owner.login)")
                Text("Owner Type: \(repo.owner.type)")
                
                Text("Gravatar ID: \(repo.owner.gravatarId)")
            }
            
            if let imageURLs {
                Section(header: Text("Images")) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(imageURLs, id: \.self) { image in
                                AsyncImage(url: image) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 200)
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                    }
                    .scrollClipDisabled(true)
                }
                .listRowBackground(Color.clear)
                .listSectionSeparator(.hidden)
                .listSectionSeparatorTint(.clear)
            }
            
            if let license = repo.license {
                Section(header: Text("License Info")) {
                    Text("License Name: \(license.name)")
                    Text("SPDX ID: \(license.spdxId)")
                }
            }
        }
        .navigationTitle("Repository Details")
        .onAppear { loadImages() }
    }
    
    @MainActor func loadImages() {
        Task {
            do {
                let urls: [URL] = try await GitHubService.shared.fetch(
                    endpoint: GitHubEndpoint.getReadmeImages(
                        owner: repo.owner.login,
                        repo: repo.name
                    )
                )
                imageURLs = urls
            } catch let error as APIError {
                if case .invalidData = error {
                    return
                }
                print("Error: \(error.localizedDescription)")
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    RepositoryDetailView(repo: .mock)
        .preferredColorScheme(.dark)
}
