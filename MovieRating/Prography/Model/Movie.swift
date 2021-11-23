import Foundation

struct Movie: Codable {
    let title: String?
    let rating: Double?
    let large_cover_image: String?
    let background_image: String?
}

extension Movie {
    static let Empty = Movie.init(title: "", rating: 0, large_cover_image: "", background_image: "")
}
