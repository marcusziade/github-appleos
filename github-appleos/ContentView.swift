import SwiftUI

struct ContentView: View {
    
    @State var starredCount: Int = 0
    @State var user: GitHubUser?
    @State var repositories: [Repository] = []
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: user?.avatarUrl) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                } placeholder: {
                    ProgressView()
                }
                Text(user?.name ?? "No name")
                    .font(.headline)
                Text(user?.bio ?? "No bio")
                    .foregroundColor(.gray)
            }
            ForEach(repositories) { repo in
                HStack {
                    AsyncImage(url: repo.owner.avatarUrl) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                    } placeholder: {
                        ProgressView()
                    }

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
                .padding()
                .background(Color.gray)
                .cornerRadius(8)
                .padding(.horizontal)
            }
        }
        .onAppear {
            loadUserData()
            loadStarredRepos()
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
#if os(macOS)
        .frame(width: 200, height: 200, alignment: .center)
#endif
}
