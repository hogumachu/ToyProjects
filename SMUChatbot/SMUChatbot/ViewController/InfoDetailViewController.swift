import UIKit
import RxSwift

class InfoDetailViewController: BaseViewController {
    struct Dependency {
        let info: Info
    }
    
    // MARK: - Properties
    
    let info: Info
    let DetailBackBarButtonItem = BackBarButtonItem()
    let titleLabel = HeavyTitleLabel()
    let detailLabel = DetailLabel()
    lazy var detailView = info.detailView
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
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
        view.backgroundColor = info.color
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.leftBarButtonItem = DetailBackBarButtonItem
        self.navigationItem.title = info.title
        
        view.initAutoLayout(UIViews: [titleLabel, detailLabel, scrollView])
        scrollView.initAutoLayout(UIViews: [detailView])
        
        titleLabel.font = .systemFont(ofSize: 40, weight: .heavy)
        titleLabel.textColor = .white
        titleLabel.text = info.title
        titleLabel.numberOfLines = 0
        
        detailLabel.textColor = .white
        detailLabel.text = info.detailInfo
        detailLabel.numberOfLines = 0
        
        detailView.backgroundColor = .white
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.snp.topMargin)
            $0.leading.trailing.equalToSuperview().offset(10)
        }
        
        detailLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(titleLabel)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(detailLabel.snp.bottom).offset(5)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        detailView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        scrollView.contentSize = detailView.bounds.size
        
        
        
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
