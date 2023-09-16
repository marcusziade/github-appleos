import Foundation

enum APIError: Error {
    case invalidURL
    /// Don't print this error's localizedDescription, it's empty by design.
    case invalidData
    case cacheDecoding(Error)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidData:
            return ""
        case .cacheDecoding(let error):
            return "Error: Failed to decode cached data - \(error)"
        }
    }
}
