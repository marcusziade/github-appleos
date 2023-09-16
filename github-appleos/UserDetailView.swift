import SwiftUI

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

#Preview {
    UserDetailView(user: .mock)
}
