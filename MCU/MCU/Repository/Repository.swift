import Foundation

class Repository {
    static let shared = Repository()
    private static var mcuCache: [String: Mcu] = [:]
    private let baseUrl = "https://www.whenisthenextmcufilm.com/api"
    private let prefixDateUrl = "?date="
    
    func fecthData(_ url: String, completion: @escaping (Mcu?) -> Void) {
        var url = url
        
        if url.isEmpty {
            url = baseUrl
        } else {
            if !url.hasPrefix("https") {
                url = baseUrl + prefixDateUrl + url
            }
        }
        
        if let mcu = Repository.mcuCache[url] {
            completion(mcu)
            return
        }
        
        // TODO: - url (String), Url (URL) 이름 변경
        guard let Url = URL(string: url) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: Url) { data, response, error in
            if let error = error {
                print(error)
                completion(nil)
                return
            }
            
            guard let response = response else {
                print("Response Error")
                completion(nil)
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                print("Can't Get StatusCode")
                completion(nil)
                return
            }
            
            guard (200...299).contains(statusCode) else {
                print("StatusCode:", statusCode)
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Data Error")
                completion(nil)
                return
            }
            
            DispatchQueue.global().async {
                let decoder = JSONDecoder()
                do {
                    let jsonData = try decoder.decode(Mcu.self, from: data)
                    Repository.mcuCache[url] = jsonData
                    completion(jsonData)
                } catch {
                    print("Can't Decode Data", error)
                    print(url)
                    completion(nil)
                }
            }
        }.resume()
    }
}
