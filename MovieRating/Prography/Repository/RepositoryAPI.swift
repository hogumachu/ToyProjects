import Foundation

class Repository {
    static let shared = Repository()
    private init() {}
    
    let baseURL = "https://yts.mx/api/v2/list_movies.json"
    
    func execute<T: Codable>(url: String, completion: @escaping (Result<T, Error>) -> Void) {
        let url = URL(string: url)!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(RepositoryError.response))
                return
            }
            
            guard (200..<300).contains(response.statusCode) else {
                completion(.failure(RepositoryError.status))
                return
            }
            
            guard let data = data else {
                completion(.failure(RepositoryError.data))
                return
            }
            
            do {
                let json = try JSONDecoder().decode(T.self, from: data)
                completion(.success(json))
            } catch {
                completion(.failure(RepositoryError.decoding))
            }
            
        }.resume()
    }
    
    func generateURL(score: String, page: Int) -> String {
        return "https://yts.mx/api/v2/list_movies.json?limit=20&minimum_rating=\(score)&sort_by=rating&order_by=asc&page=\(page)"
    }
}

public enum RepositoryError: Error {
    case response
    case status
    case data
    case decoding
}

extension RepositoryError: LocalizedError {
    public var localizedDescription: String {
        switch self {
        case .response:
            return "Response Error"
        case .status:
            return "Status Code Error"
        case .data:
            return "Data Error"
        case .decoding:
            return "Decoding Error"
        }
    }
    
}
