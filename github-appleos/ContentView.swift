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
                        RepositoryRow(repo: repo)
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




#Preview {
    ContentView()
        .frame(width: 1000, height: 1000, alignment: .center)
}
