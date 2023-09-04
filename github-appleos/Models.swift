import Foundation

struct GitHubUser: Codable, Identifiable {
    let avatarURL: URL?
    let bio: String?
    let blog: String?
    let collaborators: Int
    let company: String?
    let createdAt: String
    let diskUsage: Int
    let email: String?
    let eventsURL: URL?
    let followers: Int
    let followersURL: URL?
    let following: Int
    let followingURL: URL?
    let gistsURL: URL?
    let gravatarID: String?
    let hireable: Bool?
    let id: Int
    let location: String?
    let login: String
    let name: String
    let organizationsURL: URL?
    let ownedPrivateRepos: Int
    let plan: Plan
    let privateGists: Int
    let publicGists: Int
    let publicRepos: Int
    let receivedEventsURL: URL?
    let reposURL: URL?
    let siteAdmin: Bool
    let starredURL: URL?
    let subscriptionsURL: URL?
    let totalPrivateRepos: Int
    let twitterUsername: String?
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
    let avatarURL: URL?
    let eventsURL: URL?
    let followersURL: URL?
    let gistsURL: URL?
    let gravatarID: String?
    let id: Int
    let login: String
    let organizationsURL: URL?
    let receivedEventsURL: URL?
    let reposURL: URL?
    let siteAdmin: Bool
    let starredURL: URL?
    let subscriptionsURL: URL?
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
    let collaboratorsURL: URL?
    let defaultBranch: String
    let description: String?
    let eventsURL: URL?
    let forks: Int
    let forksURL: URL?
    let fullName: String
    let `private`: Bool
    let hooksURL: URL?
    let id: Int
    let isTemplate: Bool
    let issueEventsURL: URL?
    let keysURL: URL?
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
