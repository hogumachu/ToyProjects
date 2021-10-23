import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxKeyboard

class MainViewController: BaseViewController {
    struct Dependency {
        let viewModel: MainViewModel
    }
    
    // MARK: - Properties
    
    let viewModel: MainViewModel
    
    let shakerLabel: UILabel = {
        let uiLabel = UILabel()
        uiLabel.text = "SHAKER"
        uiLabel.textColor = .systemGreen
        uiLabel.font = .systemFont(ofSize: 50, weight: .heavy)
        return uiLabel
    }()
    
    let sendButton: UIButton = {
        let uiButton = UIButton()
        uiButton.setTitle(" Send ", for: .normal)
        uiButton.setTitleColor(.white, for: .normal)
        uiButton.backgroundColor = .systemGreen
        uiButton.layer.masksToBounds = true
        uiButton.layer.cornerRadius = 10
        
        return uiButton
    }()
    
    let searchView: UIView = {
        let uiView = UIView()
        uiView.layer.cornerRadius = 15
        uiView.layer.borderWidth = 1
        uiView.layer.borderColor = UIColor.systemGreen.cgColor
        return uiView
    }()
    
    let textField: UITextField = {
        let uiTextField = UITextField()
        return uiTextField
    }()
    
    let keyboardPaddingView: UIView = {
        let uiView = UIView()
        return uiView
    }()
    
    // MARK: - Lifecycles
    
    init(dependency: Dependency, payload: ()) {
        viewModel = dependency.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Configures
    
    override func configureUI() {
        view.backgroundColor = .white
        
        view.addSubviews(shakerLabel, searchView, keyboardPaddingView)
        
        searchView.addSubview(sendButton)
        searchView.addSubview(textField)
        
        shakerLabel.snp.makeConstraints {
            $0.centerX.equalTo(view)
            $0.bottom.equalTo(searchView.snp.top).offset(-20)
        }
        
        searchView.snp.makeConstraints {
            $0.centerX.centerY.equalTo(view)
            $0.height.equalTo(50)
            
            $0.leading.equalTo(view).offset(10)
            $0.trailing.equalTo(view).offset(-10)
        }
        
        sendButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-5)
            $0.top.equalToSuperview().offset(5)
            $0.bottom.equalToSuperview().offset(-5)
            $0.width.equalTo(50)
        }
        
        textField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalTo(sendButton.snp.leading).offset(-5)
        }
        
    }
    
    // MARK: - Subscribe
    
    override func subscribe() {
        sendButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                if let text = textField.text {
                    coordinator?.pushSearchViewController(searchText: text)
                }
            })
            .disposed(by: disposeBag)
    }
}
