import Foundation

extension String {
    var htmlRemove: String {
        guard let encodeData = self.data(using: .utf8) else {
            return self
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue]
        
        do {
            let attributed = try NSAttributedString(data: encodeData, options: options, documentAttributes: nil)
            
            return attributed.string
        } catch {
            return self
        }
    }
}
