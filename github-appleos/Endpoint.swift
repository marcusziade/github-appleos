import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    var httpMethod: String { get }
}

extension Endpoint {
    
    var baseURL: String {
        return "127.0.0.1"
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
}

enum GitHubEndpoint: Endpoint {
    case getUser(username: String)
    case getAuthUser
    case getStarred(username: String, pages: Int)
    
    var path: String {
        switch self {
        case .getUser(let username):
            return "/github_user/\(username)"
        case .getAuthUser:
            return "/user"
        case .getStarred(let username, _):
            return "/github_starred/\(username)"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .getStarred(_, let pages):
            return [URLQueryItem(name: "pages", value: String(pages))]
        default:
            return []
        }
    }
    
    var httpMethod: String {
        switch self {
        case .getUser:
            return "GET"
        case .getAuthUser:
            return "GET"
        case .getStarred:
            return "GET"
        }
    }
}
