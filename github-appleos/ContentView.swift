import SwiftUI
#if os(iOS)
import UIKit
#else
import AppKit
#endif
import Foundation

struct ContentView: View {
    
    @State var starredCount: Int = 0
    @State var user: GitHubUser?
    @State var repositories: [Repository] = []
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if let user = user {
                        UserDetailView(user: user)
                    }
                    
                    ForEach(repositories) { repo in
                        RepositoryView(repo: repo)
                    }
                }
            }
            .navigationTitle("GitHub Profile")
            .onAppear {
                loadUserData()
                loadStarredRepos()
            }
#if os(iOS)
            .navigationViewStyle(.stack)
#endif
        }
    }
    
    func loadUserData() {
        Task {
            do {
                user = try await GitHubService.shared.fetch(
                    endpoint: GitHubEndpoint.getUser(
                        username: "marcusziade"
                    )
                )
            } catch {
                print("Failed to load user data: \(error)")
            }
        }
    }
    
    func loadStarredRepos() {
        Task {
            do {
                repositories = try await GitHubService.shared.fetch(
                    endpoint: GitHubEndpoint.getStarred(
                        username: "marcusziade",
                        pages: 2
                    )
                )
                starredCount = repositories.count
            } catch {
                print("Failed to load starred repos: \(error)")
            }
        }
    }
}

struct UserDetailView: View {
    let user: GitHubUser
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                AsyncImage(url: user.avatarUrl) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                } placeholder: {
                    ProgressView()
                }
                .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(user.name)
                        .font(.headline)
                    Text(user.bio ?? "No bio")
                        .foregroundColor(.gray)
                    Text(user.location ?? "No location")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            
            if let company = user.company {
                Text("Company: \(company)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            if let blog = user.blog {
                Text("Blog: \(blog)")
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }
            
            Text("Twitter: @\(user.twitterUsername)")
                .font(.subheadline)
                .foregroundColor(.blue)
            
            Text("Public Repositories: \(user.publicRepos)")
                .font(.subheadline)
            
            Text("Followers: \(user.followers)")
                .font(.subheadline)
            
            Text("Following: \(user.following)")
                .font(.subheadline)
        }
        .padding()
    }
}

struct RepositoryView: View {
    let repo: Repository
    
    var body: some View {
        NavigationLink(destination: {
            RepositoryDetailView(repo: repo)
        }, label: {
            VStack(alignment: .leading) {
                HStack {
                    AsyncImage(url: repo.owner.avatarUrl) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 50)
                    } placeholder: {
                        ProgressView()
                    }
                    .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text(repo.name)
                            .font(.headline)
                        Text(repo.description ?? "No description")
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("\(repo.watchers)")
                    }
                }
                
                Text("Forks: \(repo.forks)")
                    .font(.subheadline)
                
                if let license = repo.license {
                    Text("License: \(license.name)")
                        .font(.subheadline)
                }
                
                Text("Visibility: \(repo.visibility)")
                    .font(.subheadline)
            }
        })
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        .padding(.horizontal)
    }
}

struct RepositoryDetailView: View {
    let repo: Repository
    
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
            
            Section(header: Text("Repository URLs")) {
            }
            
            if let license = repo.license {
                Section(header: Text("License Info")) {
                    Text("License Name: \(license.name)")
                    Text("SPDX ID: \(license.spdxId)")
                }
            }
        }
        .navigationTitle("Repository Details")
    }
}

#Preview {
    ContentView()
        .frame(width: 1000, height: 1000, alignment: .center)
}
