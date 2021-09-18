import UIKit
import RxSwift
import SnapKit

class InfoDetailTeamViewController: BaseViewController {
    struct Dependency {
        let info: Info
    }
    
    // MARK: - Properties
    
    let info: Info
    let backBarButtonItem = BackBarButtonItem()
    let pageControl = UIPageControl()
    let iOSGitButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "github_logo"), for: .normal)
        return button
    }()
    let djangoGitButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "github_logo"), for: .normal)
        return button
    }()
    let iOSLabel: UILabel = {
        let label = UILabel()
        label.text = "iOS"
        return label
    }()
    let djangoLabel: UILabel = {
        let label = UILabel()
        label.text = "Django"
        return label
    }()
    let documentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 50, weight: .heavy)
        label.text = "개발 문서 보기"
        return label
    }()
    
    // MARK: - Lifecycles
    
    init(dependency: Dependency, payload: ()) {
        self.info = dependency.info
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Configures
    
    override func configureUI() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        view.backgroundColor = .white
        view.initAutoLayout(UIViews: [documentLabel, iOSGitButton, iOSLabel, djangoGitButton, djangoLabel, pageControl])
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .systemGray
        pageControl.currentPageIndicatorTintColor = .black
        
        pageControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        documentLabel.snp.makeConstraints {
            $0.top.leading.equalTo(view.safeAreaLayoutGuide).offset(5)
        }
        
        iOSGitButton.snp.makeConstraints {
            $0.top.equalTo(documentLabel.snp.bottom).offset(10)
            $0.leading.equalTo(documentLabel)
            $0.width.height.equalTo(40)
        }
        
        iOSLabel.snp.makeConstraints {
            $0.centerY.equalTo(iOSGitButton)
            $0.leading.equalTo(iOSGitButton.snp.trailing).offset(10)
        }
        
        djangoGitButton.snp.makeConstraints {
            $0.top.equalTo(iOSGitButton.snp.bottom).offset(10)
            $0.leading.equalTo(iOSGitButton)
            $0.width.height.equalTo(40)
        }
        
        djangoLabel.snp.makeConstraints {
            $0.centerY.equalTo(djangoGitButton)
            $0.leading.equalTo(djangoGitButton.snp.trailing).offset(10)
        }
        
        backBarButtonItem.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.navigationController?.navigationBar.isHidden = true
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    
    // MARK: - Subscribes
    
    override func subscribe() {
        iOSGitButton.rx.tap
            .subscribe(onNext: {
                print("TODO: iOS Github 페이지로 가기")
            })
            .disposed(by: disposeBag)
        
        djangoGitButton.rx.tap
            .subscribe(onNext: {
                print("TODO: Django Github 페이지로 가기")
            })
            .disposed(by: disposeBag)
    }

}
