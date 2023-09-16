import Foundation
import UIKit

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
            print("Error: Invalid URL")
            throw APIError.invalidURL
        }
        
        let urlString = url.absoluteString as NSString
        
        if let cachedData = cache.object(forKey: urlString) {
            do {
                let decodedData = try jsonDecoder.decode(T.self, from: cachedData as Data)
                print("Info: Data retrieved from cache")
                return decodedData
            } catch {
                print("Error: Failed to decode cached data - \(error)")
                throw APIError.cacheDecoding(error)
            }
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod
        request.addValue("Bearer \(Keys.githubAPIKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("2022-11-28", forHTTPHeaderField: "X-GitHub-Api-Version")
        
        do {
            let (data, _) = try await session.data(for: request)
            
            if let jsonString = String(data: data, encoding: .utf8) {
                // No-op, use for debugging
            }
            
            let decodedData = try jsonDecoder.decode(T.self, from: data)
            print("Success: Data decoded successfully")
            
            cache.setObject(data as NSData, forKey: urlString)
            return decodedData
        } catch {
            print("Error: Data fetching or decoding failed - \(error)")
            debugPrint(error.localizedDescription)
            throw APIError.invalidData
        }
    }
    
    func fetchImage(url: URL) async throws -> UIImage {
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw APIError.invalidData
        }
        return image
    }
    
    // MARK: Private
    
    private let session = URLSession.shared
    
    private let jsonDecoder: JSONDecoder = {
        let d = JSONDecoder()
        d.keyDecodingStrategy = .convertFromSnakeCase
        return d
    }()
}
