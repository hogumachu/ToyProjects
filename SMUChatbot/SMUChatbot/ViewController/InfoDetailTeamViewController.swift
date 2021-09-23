import UIKit
import RxSwift
import SnapKit
import Kingfisher

class InfoDetailTeamViewController: BaseViewController {
    struct Dependency {
        let info: Info
    }
    
    // MARK: - Properties
    
    let info: Info
    let backBarButtonItem = BackBarButtonItem()
    let imageView = AnimatedImageView()
//    let pageControl = UIPageControl()
//    let iOSGitButton: UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(named: "github_logo"), for: .normal)
//        return button
//    }()
//    let djangoGitButton: UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(named: "github_logo"), for: .normal)
//        return button
//    }()
//    let iOSLabel: UILabel = {
//        let label = UILabel()
//        label.text = "iOS"
//        return label
//    }()
//    let djangoLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Django"
//        return label
//    }()
//    let documentLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 50, weight: .heavy)
//        label.text = "개발 문서 보기"
//        return label
//    }()
    let descripLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "❶ 이전 페이지에서 우측으로 이동합니다"
        label.numberOfLines = 0
        label.textAlignment = .left
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
        // TODO: - urlString Model 로 옮기기
        downloadImage(urlString: "https://user-images.githubusercontent.com/74225754/133364875-b18ca2e5-85da-479d-856c-e008440e82bf.gif")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        imageView.stopAnimating()
    }
    
    // MARK: - Configures
    
    override func configureUI() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        view.backgroundColor = .white
        view.initAutoLayout(UIViews: [imageView, descripLabel])
        
        imageView.layer.cornerRadius = 10
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(descripLabel.snp.bottom).offset(20)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        descripLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.lessThanOrEqualToSuperview().offset(-20)
        }
        
        
//        view.initAutoLayout(UIViews: [documentLabel, iOSGitButton, iOSLabel, djangoGitButton, djangoLabel, pageControl])
//        pageControl.numberOfPages = 3
//        pageControl.currentPage = 0
//        pageControl.pageIndicatorTintColor = .systemGray
//        pageControl.currentPageIndicatorTintColor = .black
//
//        pageControl.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.bottom.equalToSuperview().offset(-20)
//        }
//
//        documentLabel.snp.makeConstraints {
//            $0.top.leading.equalTo(view.safeAreaLayoutGuide).offset(5)
//        }
//
//        iOSGitButton.snp.makeConstraints {
//            $0.top.equalTo(documentLabel.snp.bottom).offset(10)
//            $0.leading.equalTo(documentLabel)
//            $0.width.height.equalTo(40)
//        }
//
//        iOSLabel.snp.makeConstraints {
//            $0.centerY.equalTo(iOSGitButton)
//            $0.leading.equalTo(iOSGitButton.snp.trailing).offset(10)
//        }
//
//        djangoGitButton.snp.makeConstraints {
//            $0.top.equalTo(iOSGitButton.snp.bottom).offset(10)
//            $0.leading.equalTo(iOSGitButton)
//            $0.width.height.equalTo(40)
//        }
//
//        djangoLabel.snp.makeConstraints {
//            $0.centerY.equalTo(djangoGitButton)
//            $0.leading.equalTo(djangoGitButton.snp.trailing).offset(10)
//        }
        
        backBarButtonItem.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.navigationController?.navigationBar.isHidden = true
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    func downloadImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        imageView.kf.setImage(with: url) { [weak self] result in
            switch result {
            case .success(_):
                self?.imageView.startAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Subscribes
    
    override func subscribe() {
//        iOSGitButton.rx.tap
//            .subscribe(onNext: {
//                print("TODO: iOS Github 페이지로 가기")
//            })
//            .disposed(by: disposeBag)
//
//        djangoGitButton.rx.tap
//            .subscribe(onNext: {
//                print("TODO: Django Github 페이지로 가기")
//            })
//            .disposed(by: disposeBag)
    }

}
