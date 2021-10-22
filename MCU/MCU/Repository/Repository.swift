import Foundation

class Repository {
    static let shared = Repository()
    private static var mcuCache: [String: Mcu] = [:]
    private let baseUrl = "https://www.whenisthenextmcufilm.com/api"
    private let prefixDateUrl = "?date="
    
    func fecthData(_ url: String, completion: @escaping (Result<Mcu, NetworkError>) -> Void) {
        var url = url
        
        if url.isEmpty {
            url = baseUrl
        } else {
            if !url.hasPrefix("https") {
                url = baseUrl + prefixDateUrl + url
            }
        }
        
        if let mcu = Repository.mcuCache[url] {
            completion(.success(mcu))
            return
        }
        
        // TODO: - url (String), Url (URL) 이름 변경
        guard let Url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: Url) { data, response, error in
            if let _ = error {
                completion(.failure(.dataTaskError))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.responseError))
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                completion(.failure(.statusCodeError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            DispatchQueue.global().async {
                let decoder = JSONDecoder()
                do {
                    let jsonData = try decoder.decode(Mcu.self, from: data)
                    Repository.mcuCache[url] = jsonData
                    completion(.success(jsonData))
                } catch {
                    completion(.failure(.decodeError))
                }
            }
        }.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case dataTaskError
    case responseError
    case statusCodeError
    case invalidData
    case decodeError
}
