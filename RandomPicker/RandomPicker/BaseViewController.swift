import UIKit
import RxSwift

class BaseViewController: UIViewController {
    var coordinator: Coordinator?
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        configureUI()
        subscribe()
    }
    
    func configureUI() {
        
    }
    
    func subscribe() {
        
    }
}
