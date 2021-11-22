import UIKit.UIImage

class ImageCacheManager {
    static let shared = ImageCacheManager()
    private init() {}
    private let cache = NSCache<NSString, UIImage>()
    
    func loadImage(_ key: String) -> UIImage? {
        let nsKey = NSString(string: key)
        
        return cache.object(forKey: nsKey)
    }
    
    func saveImage(_ key: String, image: UIImage) {
        let nsKey = NSString(string: key)
        
        cache.setObject(image, forKey: nsKey)
    }
}
