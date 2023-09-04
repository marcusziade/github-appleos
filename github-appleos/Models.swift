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
    let gravatarID: String?
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
}

struct License: Codable {
    let key: String
    let name: String
    let spdxID: String?
    let url: String?
}

struct Owner: Codable, Identifiable {
    let avatarUrl: URL
    let eventsUrl: URL
    let followersUrl: URL
    let gistsUrl: URL
    let gravatarID: String?
    let id: Int
    let login: String
    let organizationsUrl: URL
    let receivedEventsUrl: URL
    let reposUrl: URL
    let siteAdmin: Bool
    let starredUrl: URL
    let subscriptionsUrl: URL
    let type: String
    let url: URL
}

struct Permissions: Codable {
    let admin: Bool
    let maintain: Bool
    let pull: Bool
    let push: Bool
    let triage: Bool
}

struct Plan: Codable {
    let collaborators: Int
    let name: String
    let privateRepos: Int
    let space: Int
}

struct Repository: Codable, Identifiable {
    let allowForking: Bool
    let collaboratorsUrl: URL
    let defaultBranch: String
    let description: String?
    let eventsUrl: URL
    let forks: Int
    let forksURL: URL?
    let fullName: String
    let `private`: Bool
    let hooksURL: URL?
    let id: Int
    let isTemplate: Bool
    let issueEventsUrl: URL
    let keysUrl: URL
    let license: License?
    let name: String
    let openIssues: Int
    let owner: Owner
    let permissions: Permissions
    let topics: [String]
    let url: URL
    let visibility: String
    let watchers: Int
    let webCommitSignoffRequired: Bool
}
