import Foundation

struct ImageDataList: Codable, Identifiable {
    var id = UUID()
    let urls: [URL]
    
    static var mock: Self {
        .init(
            urls: [URL(string: "https://avatars.githubusercontent.com/u/69")!]
        )
    }
}
