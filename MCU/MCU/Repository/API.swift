import Foundation

protocol API {
    associatedtype DecodableType: Decodable
}

extension API {
    func execute(_ url: URL, completionHandler: @escaping (Result<DecodableType, APIError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                completionHandler(.failure(.responseError))
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                completionHandler(.failure(.statusCodeError))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.invalidData))
                return
            }
            
            do {
                let jsonData =  try JSONDecoder().decode(DecodableType.self, from: data)
                completionHandler(.success(jsonData))
            } catch {
                completionHandler(.failure(.decodeError))
            }
        }.resume()
        
    }
}

enum APIError: Error {
    case invalidURL
    case responseError
    case statusCodeError
    case invalidData
    case decodeError
}
