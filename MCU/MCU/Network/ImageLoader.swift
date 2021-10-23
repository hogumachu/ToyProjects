import UIKit

class ImageLoader {
    private static var imageCache: [String: UIImage] = [:]
    
    static func loadImage(url: String, completion: @escaping (Result<UIImage, ImageLoadError>) -> Void) {
        if url.isEmpty {
            DispatchQueue.main.async {
                completion(.failure(.invalidURL))
            }
            return
        }
        
        if let image = imageCache[url] {
            DispatchQueue.main.async {
                completion(.success(image))
            }
            return
        }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: URL(string: url)!) {
                guard let image = UIImage(data: data) else { return }
                imageCache[url] = image
                
                DispatchQueue.main.async {
                    completion(.success(image))
                }
                
            } else {
                DispatchQueue.main.async {
                    completion(.failure(.decodeError))
                }
            }
        }
    }
}

enum ImageLoadError: Error {
    case invalidURL
    case decodeError
}
