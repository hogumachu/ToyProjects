import UIKit

class ImageLoader {
    private static var imageCache: [String: UIImage] = [:]
    
    static func loadImage(url: String, completion: @escaping (UIImage?) -> Void) {
        if url.isEmpty {
            DispatchQueue.main.async {
                completion(nil)
            }
            
            return
        }
        
        if let image = imageCache[url] {
            DispatchQueue.main.async {
                completion(image)
            }
            return
        }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: URL(string: url)!) {
                let image = UIImage(data: data)
                imageCache[url] = image
                
                DispatchQueue.main.async {
                    completion(image)
                }
                
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
        
    }
}
