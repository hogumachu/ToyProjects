import UIKit.UIImage

class ImageLoader {
    static func fetchImage(url: String, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            if url.isEmpty {
                DispatchQueue.main.async {
                    completion(nil)
                }
                
                return
            }
            
            if let image = ImageCacheManager.shared.loadImage(url) {
                DispatchQueue.main.async {
                    completion(image)
                }
                return
            }
            
            URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
                if let _ = error {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }
                
                guard (200..<300).contains(response.statusCode) else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }
                
                guard let data = data else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }
                
                let image = UIImage(data: data)
                
                guard let image = image else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }
                
                ImageCacheManager.shared.saveImage(url, image: image)
                DispatchQueue.main.async {
                    completion(image)
                }
            }
            .resume()
        }
        
    }
}
