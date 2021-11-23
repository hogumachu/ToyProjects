import Foundation

struct DataClass: Codable {
    let movieCount: Int?
    let limit: Int?
    let page_number: Int?
    var movies: [Movie]?
}

extension DataClass {
    static let Empty: DataClass = .init(movieCount: 0, limit: 0, page_number: 0, movies: [])
}
