import Foundation
import SwiftUI

struct RepositoryRow: View {
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

#Preview {
    RepositoryRow(repo: .mock)
}
