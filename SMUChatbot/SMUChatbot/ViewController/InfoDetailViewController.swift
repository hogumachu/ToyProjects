import UIKit
import RxSwift

class InfoDetailViewController: BaseViewController {
    struct Dependency {
        let info: Info
    }
    
    // MARK: - Properties
    
    let info: Info
    let DetailBackBarButtonItem = BackBarButtonItem()
    
    // MARK: - Lifecycles
    
    required init(dependency: Dependency, payload: ()) {
        self.info = dependency.info
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        subscribe()
    }
    
    // MARK: - Configures
    
    override func configureUI() {
        view.backgroundColor = .smu
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.leftBarButtonItem = DetailBackBarButtonItem
        self.navigationItem.title = info.title
    }
    
    // MARK: - Subscribes
    
    override func subscribe() {
        DetailBackBarButtonItem.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                guard let topVC = navigationController?.topViewController else { return }
                if let _ = topVC as? InfoDetailViewController {
                    self.navigationController?.navigationBar.isHidden = true
                    self.navigationController?.popViewController(animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
