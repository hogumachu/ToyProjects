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
    
    let sendButton: UIButton = {
        let uiButton = UIButton()
        uiButton.setTitle(" Send ", for: .normal)
        uiButton.setTitleColor(.white, for: .normal)
        uiButton.backgroundColor = .systemGreen
        uiButton.layer.masksToBounds = true
        uiButton.layer.cornerRadius = 10
        
        return uiButton
    }()
    
    let textView: UITextView = {
        let uiTextView = UITextView()
        uiTextView.font = UIFont.systemFont(ofSize: 20)
        uiTextView.isSelectable = false
        return uiTextView
    }()
    
    let textField: UITextField = {
        let uiTextField = UITextField()
        uiTextField.layer.borderWidth = 1
        uiTextField.layer.borderColor = UIColor.systemGray.cgColor
        uiTextField.layer.cornerRadius = 10
        return uiTextField
    }()
    
    let keyboardPaddingView: UIView = {
        let uiView = UIView()
        return uiView
    }()
    
    let mapButton: UIBarButtonItem = {
        let uiBarButton = UIBarButtonItem()
        uiBarButton.title = "Map"
        uiBarButton.tintColor = .systemGreen
        return uiBarButton
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
        title = "MainViewController"
        view.backgroundColor = .white
        
        view.addSubview(sendButton)
        view.addSubview(textView)
        view.addSubview(textField)
        view.addSubview(keyboardPaddingView)
        
        navigationItem.rightBarButtonItem = mapButton
        
        textView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(textField.snp.top).offset(-5)
        }
        
        textField.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(5)
            $0.bottom.equalTo(sendButton.snp.bottom)
            $0.trailing.equalTo(sendButton.snp.leading).offset(-5)
            $0.height.equalTo(sendButton)
        }
        
        sendButton.snp.makeConstraints {
            $0.width.equalTo(50)
            $0.height.equalTo(30)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-5)
            $0.bottom.equalTo(keyboardPaddingView.snp.top).offset(-5)
        }
        
        keyboardPaddingView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(keyboardPaddingView.snp.bottom)
        }
        
    }
    
    override func subscribe() {
        sendButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                viewModel.searchRequest(textField.text!)
                textField.text = ""
            })
            .disposed(by: disposeBag)
        
        mapButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                coordinator?.pushMapViewController()
            })
            .disposed(by: disposeBag)
        
        viewModel.searchRelay
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] items in
                textView.text = ""
                items.forEach {
                    if let title = $0.title {
                        textView.text += title.htmlRemove
                        textView.text += "\n"
                    }
                    if let address = $0.roadAddress {
                        textView.text += address.htmlRemove
                        textView.text += "\n"
                    }
                    
                    if let telephon = $0.telephon {
                        textView.text += telephon.htmlRemove
                        textView.text += "\n"
                    }
                    textView.text += "\n"
                }
            })
            .disposed(by: disposeBag)
        
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [unowned self] keyboardHeight in
                keyboardPaddingView.snp.updateConstraints {
                    $0.top.equalTo(keyboardPaddingView.snp.bottom).offset(-keyboardHeight)
                }
                view.layoutIfNeeded()
            })
            .disposed(by: disposeBag)
        
        
    }
}
