import Foundation

class ViewModelType: NSObject {
    let storage: Storable
    
    init(storage: Storable) {
        self.storage = storage
    }
}
