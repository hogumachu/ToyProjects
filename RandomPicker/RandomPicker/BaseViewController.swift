import UIKit

class BaseViewController: UIViewController {
    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        configureUI()
        subscribe()
    }
    
    func configureUI() {
        
    }
    
    func subscribe() {
        
    }
}
