import UIKit.UIImage

class ImageLoader {
    private static var imageCache = NSMutableDictionary()
    
    static func fetchImage(url: String, completion: @escaping (UIImage?) -> Void) {
        if url.isEmpty {
            completion(nil)
            return
        }
        
        if imageCache[url] != nil {
            completion(imageCache[url] as? UIImage)
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
            
            self.imageCache[url] = image
            completion(image)
        }
        .resume()
        
    }
}
