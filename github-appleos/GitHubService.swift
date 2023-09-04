import Foundation

final class GitHubService {
    
    static let shared = GitHubService()
    
    private init() {}
    
    private var cache = NSCache<NSString, NSData>()
    
    func fetch<T: Codable>(endpoint: Endpoint) async throws -> T {
        var components = URLComponents()
        components.scheme = "http"
        components.host = endpoint.baseURL
        components.port = 8080
        components.path = endpoint.path
        components.queryItems = endpoint.queryItems
        
        guard let url = components.url else {
            throw APIError.invalidURL
        }
        
        let urlString = url.absoluteString as NSString
        
        if let cachedData = cache.object(forKey: urlString) {
            let decodedData = try jsonDecoder.decode(T.self, from: cachedData as Data)
            return decodedData
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod
        request.addValue("Bearer \(Keys.githubAPIKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("2022-11-28", forHTTPHeaderField: "X-GitHub-Api-Version")
        
        let (data, _) = try await session.data(for: request)
        
        do {
            let decodedData = try jsonDecoder.decode(T.self, from: data)
            cache.setObject(data as NSData, forKey: urlString)
            return decodedData
        } catch {
            throw APIError.invalidData
        }
    }
    
    // MARK: Private
    
    private let session = URLSession.shared
    
    private let jsonDecoder: JSONDecoder = {
        let d = JSONDecoder()
        d.keyDecodingStrategy = .convertFromSnakeCase
        return d
    }()
}

enum APIError: Error {
    case invalidURL
    case invalidData
}
