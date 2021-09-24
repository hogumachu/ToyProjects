import UIKit
import RxSwift
import SnapKit

class InfoPopupViewController: BaseViewController {
    let popUpView = UIView()
    let backButton = UIButton()
    
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
    
    override func configureUI() {
        view.backgroundColor = .init(white: 0, alpha: 0.3)
        // view에 넣는 순서 중요
        view.initAutoLayout(UIViews: [backButton, popUpView])
        popUpView.layer.cornerRadius = 20
        popUpView.backgroundColor = .white
        
        popUpView.initAutoLayout(UIViews: [documentLabel, iOSGitButton, iOSLabel, djangoGitButton, djangoLabel])
        
        backButton.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        popUpView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(documentLabel.snp.width).offset(10)
            $0.height.equalTo(documentLabel.snp.height).offset(120)
        }
        
        documentLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(5)
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
    }
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
        
        backButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: false, completion: nil)
            })
            .disposed(by: disposeBag)
    }
}
