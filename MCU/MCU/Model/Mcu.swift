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
    
//    init(daysUntil: Int, overview: String, posterUrl: String, releaseDate: String, title: String, type: String, followingProduction: FollowingProduction?) {
//        self.daysUntil = daysUntil
//        self.overview = overview
//        self.posterUrl = posterUrl
//        self.releaseDate = releaseDate
//        self.title = title
//        self.type = type
//        self.followingProduction = followingProduction
//    }
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

extension Mcu {
    static let empty = Mcu(daysUntil: 0, overview: "", posterUrl: "", releaseDate: "", title: "", type: "", followingProduction: FollowingProduction(daysUntil: nil, overview: nil, posterUrl: nil, releaseDate: nil, title: nil, type: nil))
}
