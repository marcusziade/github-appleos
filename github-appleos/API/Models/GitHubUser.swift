import Foundation

struct GitHubUser: Codable, Identifiable {
    let avatarUrl: URL?
    let bio: String?
    let blog: String?
    let collaborators: Int
    let company: String?
    let createdAt: String
    let diskUsage: Int
    let email: String?
    let eventsUrl: URL
    let followers: Int
    let followersUrl: URL
    let following: Int
    let followingUrl: URL
    let gistsUrl: URL
    let gravatarId: String?
    let hireable: Bool?
    let id: Int
    let location: String?
    let login: String
    let name: String
    let organizationsUrl: URL
    let ownedPrivateRepos: Int
    let plan: Plan
    let privateGists: Int
    let publicGists: Int
    let publicRepos: Int
    let receivedEventsUrl: URL
    let reposUrl: URL
    let siteAdmin: Bool
    let starredUrl: URL
    let subscriptionsUrl: URL
    let totalPrivateRepos: Int
    let twitterUsername: String
    let twoFactorAuthentication: Bool
    let type: String
    let updatedAt: String
    let url: URL
    
    static var mock: Self {
        .init(
            avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/1?v=4"),
            bio: "Stay hungry, stay foolish.",
            blog: "https://www.linkedin.com/in/stevejobs/",
            collaborators: 1,
            company: "Apple",
            createdAt: "2007-10-20T05:10:41Z",
            diskUsage: 1,
            email: nil,
            eventsUrl: URL(string: "https://api.github.com/users/mojombo/events{/privacy}")!,
            followers: 1,
            followersUrl: URL(string: "https://api.github.com/users/mojombo/followers")!,
            following: 1,
            followingUrl: URL(string: "https://api.github.com/users/mojombo/following{/other_user}")!,
            gistsUrl: URL(string: "https://api.github.com/users/mojombo/gists{/gist_id}")!,
            gravatarId: nil,
            hireable: nil,
            id: 1,
            location: "Palo Alto, CA",
            login: "mojombo",
            name: "Steve Jobs",
            organizationsUrl: URL(string: "https://api.github.com/users/mojombo/orgs")!,
            ownedPrivateRepos: 1,
            plan: Plan(
                collaborators: 0,
                name: "free",
                privateRepos: 0,
                space: 976562499
            ),
            privateGists: 1,
            publicGists: 1,
            publicRepos: 1,
            receivedEventsUrl: URL(string: "https://api.github.com/users/mojombo/received_events")!,
            reposUrl: URL(string: "https://api.github.com/users/mojombo/repos")!,
            siteAdmin: false,
            starredUrl: URL(string: "https://api.github.com/users/mojombo/starred{/owner}{/repo}")!,
            subscriptionsUrl: URL(string: "https://api.github.com/users/mojombo/subscriptions")!,
            totalPrivateRepos: 1,
            twitterUsername: "stevejobs",
            twoFactorAuthentication: false,
            type: "User",
            updatedAt: "2021-10-20T05:10:41Z",
            url: URL(string: "https://api.github.com/users/mojombo")!
        )
    }
}

struct Plan: Codable {
    let collaborators: Int
    let name: String
    let privateRepos: Int
    let space: Int
    
    static var mock: Self {
        .init(
            collaborators: 0,
            name: "free",
            privateRepos: 0,
            space: 976562499
        )
    }
}
