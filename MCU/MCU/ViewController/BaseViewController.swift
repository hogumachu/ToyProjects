import UIKit

class BaseViewController: UIViewController {
    var coordinator: Coordinator?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        subscribe()
    }
    
    func configureUI() {}
    
    func subscribe() {}
}
