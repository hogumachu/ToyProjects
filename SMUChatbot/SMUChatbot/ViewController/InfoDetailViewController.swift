import UIKit
import RxSwift

class InfoDetailViewController: BaseViewController {
    struct Dependency {
        let info: Info
    }
    
    let info: Info
    
    let DetailBackkBarButtonItem = BackBarButtonItem()
    
    required init(dependency: Dependency, payload: ()) {
        self.info = dependency.info
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        subscribe()
    }
    
    override func configureUI() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.leftBarButtonItem = DetailBackkBarButtonItem
        self.navigationItem.title = info.title
    }
    
    override func subscribe() {
        DetailBackkBarButtonItem.rx.tap
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
