import Foundation

struct MovieResponse: Codable {
    let status: String?
    let statusMessage: String?
    let data: DataClass?
}
