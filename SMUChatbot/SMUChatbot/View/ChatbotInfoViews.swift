import SnapKit
import RxSwift
import UIKit

class teamChattingHaeJoView: UIView {
    let disposeBag = DisposeBag()
    
    let iosGithubButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "github_logo"), for: .normal)
        return button
    }()
    
    let djangoGithubButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "github_logo"), for: .normal)
        return button
    }()

    let iosLabel: UILabel = {
        let label = UILabel()
        label.text = "iOS"
        label.textColor = .systemPink
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    let djangoLabel: UILabel = {
        let label = UILabel()
        label.text = "Django"
        label.textColor = .systemPink
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        initAutoLayout(UIViews: [djangoGithubButton, iosLabel, djangoLabel, iosGithubButton])
        
        iosGithubButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.height.equalTo(50)
        }
        
        iosLabel.snp.makeConstraints {
            $0.centerY.equalTo(iosGithubButton)
            $0.leading.equalTo(iosGithubButton.snp.trailing).offset(5)
        }

        djangoGithubButton.snp.makeConstraints {
            $0.top.equalTo(iosGithubButton.snp.bottom).offset(5)
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(iosGithubButton)
        }

        djangoLabel.snp.makeConstraints {
            $0.centerY.equalTo(djangoGithubButton)
            $0.leading.equalTo(djangoGithubButton.snp.trailing).offset(5)
        }
        
        // TODO: tap 이 작동하지 않음 -> 이유 찾기
        iosGithubButton.rx.tap
            .subscribe(onNext: { _ in
                print("WebView 로 iOS 코드 있는 깃허브로 가기")
            }).disposed(by: disposeBag)
        
        djangoGithubButton.rx.tap
            .subscribe(onNext: { _ in
                print("WebView 로 Django 코드 있는 깃허브로 가기")
            }).disposed(by: disposeBag)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
