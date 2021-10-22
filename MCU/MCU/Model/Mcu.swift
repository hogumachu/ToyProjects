struct Mcu: Codable {
    let daysUntil: Int
    let overview: String
    let posterUrl: String
    let releaseDate: String
    let title: String
    let type: String
    let followingProduction: FollowingProduction
    
    enum CodingKeys: String, CodingKey {
        case daysUntil = "days_until"
        case overview
        case posterUrl = "poster_url"
        case releaseDate = "release_date"
        case title
        case type
        case followingProduction = "following_production"
    }
}

struct FollowingProduction: Codable {
    let daysUntil: Int?
    let overview: String?
    let posterUrl: String?
    let releaseDate: String?
    let title: String?
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case daysUntil = "days_until"
        case overview
        case posterUrl = "poster_url"
        case releaseDate = "release_date"
        case title
        case type
    }
}

extension Mcu: Equatable {
    static let empty = Mcu(daysUntil: 0, overview: "", posterUrl: "", releaseDate: "", title: "", type: "", followingProduction: FollowingProduction(daysUntil: nil, overview: nil, posterUrl: nil, releaseDate: nil, title: nil, type: nil))
    
    static func == (lhs: Mcu, rhs: Mcu) -> Bool {
        if lhs.title == rhs.title && lhs.type == rhs.type && lhs.releaseDate == rhs.releaseDate {
            return true
        }
        return false
    }
}
