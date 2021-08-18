import UIKit
import RxSwift

class BaseViewController: UIViewController {
    let disposeBag = DisposeBag()
    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        subscribe()
        configureUI()
    }
    
    func configureUI() {}
    
    func subscribe() {}
}
