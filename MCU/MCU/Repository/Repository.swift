import Foundation

class Repository: API {
    typealias DecodableType = Mcu
    
    static let shared = Repository()
    private static var mcuCache: [String: Mcu] = [:]
    private let baseUrl = "https://www.whenisthenextmcufilm.com/api"
    private let prefixDateUrl = "?date="
    
    func fecth(_ url: String, completionHandler: @escaping (Result<DecodableType, APIError>) -> Void) {
        var urlStr = url
        
        if urlStr.isEmpty {
            urlStr = baseUrl
        } else {
            if !urlStr.hasPrefix("https") {
                urlStr = baseUrl + prefixDateUrl + urlStr
            }
        }
        
        if let mcu = Repository.mcuCache[urlStr] {
            completionHandler(.success(mcu))
            return
        }
        
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        execute(url) { result in
            switch result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let err):
                completionHandler(.failure(err))
            }
        }
    }
}
