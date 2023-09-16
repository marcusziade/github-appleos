import Foundation

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
    
    static var mock: Self {
        .init(
            allowForking: true,
            collaboratorsUrl: URL(string: "https://api.github.com/repos/octocat/Hello-World/collaborators{/collaborator}")!,
            defaultBranch: "main",
            description: "This your first repo!",
            eventsUrl: URL(string: "https://api.github.com/repos/octocat/Hello-World/events")!,
            forks: 9,
            forksURL: URL(string: "https://api.github.com/repos/octocat/Hello-World/forks")!,
            fullName: "octocat/Hello-World",
            private: false,
            hooksURL: URL(string: "https://api.github.com/repos/octocat/Hello-World/hooks")!,
            id: 1296269,
            isTemplate: false,
            issueEventsUrl: URL(string: "https://api.github.com/repos/octocat/Hello-World/issues/events{/number}")!,
            keysUrl: URL(string: "https://api.github.com/repos/octocat/Hello-World/keys{/key_id}")!,
            license: License.mock,
            name: "Hello-World",
            openIssues: 0,
            owner: Owner.mock,
            permissions: Permissions.mock,
            topics: ["octocat", "atom", "electron", "API"],
            url: URL(string: "https://api.github.com/repos/octocat/Hello-World")!,
            visibility: "public",
            watchers: 80,
            webCommitSignoffRequired: false
        )
    }
}

struct License: Codable {
    let key: String
    let name: String
    let spdxId: String
    let url: String?
    
    static var mock: Self {
        .init(
            key: "mit",
            name: "MIT License",
            spdxId: "MIT",
            url: nil
        )
    }
}

struct Owner: Codable, Identifiable {
    let avatarUrl: URL
    let eventsUrl: URL
    let followersUrl: URL
    let gistsUrl: URL
    let gravatarId: String
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
    
    static var mock: Self {
        .init(
            avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/1?v=4")!,
            eventsUrl: URL(string: "https://api.github.com/users/mojombo/events{/privacy}")!,
            followersUrl: URL(string: "https://api.github.com/users/mojombo/followers")!,
            gistsUrl: URL(string: "https://api.github.com/users/mojombo/gists{/gist_id}")!,
            gravatarId: "someid",
            id: 1,
            login: "mojombo",
            organizationsUrl: URL(string: "https://api.github.com/users/mojombo/orgs")!,
            receivedEventsUrl: URL(string: "https://api.github.com/users/mojombo/received_events")!,
            reposUrl: URL(string: "https://api.github.com/users/mojombo/repos")!,
            siteAdmin: false,
            starredUrl: URL(string: "https://api.github.com/users/mojombo/starred{/owner}{/repo}")!,
            subscriptionsUrl: URL(string: "https://api.github.com/users/mojombo/subscriptions")!,
            type: "User",
            url: URL(string: "https://api.github.com/users/mojombo")!
        )
    }
}

struct Permissions: Codable {
    let admin: Bool
    let maintain: Bool
    let pull: Bool
    let push: Bool
    let triage: Bool
    
    static var mock: Self {
        .init(
            admin: false,
            maintain: false,
            pull: false,
            push: false,
            triage: false
        )
    }
}
