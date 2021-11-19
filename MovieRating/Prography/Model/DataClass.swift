import Foundation

struct DataClass: Codable {
    let movieCount: Int?
    let limit: Int?
    let page_number: Int?
    let movies: [Movie]?
}
