import UIKit.UIImage

class ImageLoader {
    
    static func fetchImage(url: String, completion: @escaping (UIImage?) -> Void) {
        if url.isEmpty {
            completion(nil)
            return
        }
        
        if let image = ImageCacheManager.shared.loadImage(url) {
            completion(image)
            return
        }
        
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            if let _ = error {
                completion(nil)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(nil)
                return
            }
            
            guard (200..<300).contains(response.statusCode) else {
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            
            guard let image = image else {
                completion(nil)
                return
            }
            
            ImageCacheManager.shared.saveImage(url, image: image)
            completion(image)
        }
        .resume()
        
    }
}
