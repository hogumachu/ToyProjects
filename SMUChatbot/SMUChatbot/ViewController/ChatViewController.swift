import UIKit
import RxSwift
import RxCocoa

class ChatViewController: BaseViewController {
    
    struct Dependency {
        let viewModel: ChatViewModel
    }
    
    // MARK: - Properties
    
    let viewModel: ChatViewModel

    let chatTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "  메시지를 입력하세요"
        textField.layer.borderColor = UIColor.smu.cgColor
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        return textField
    }()
    
    let sendButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Send ", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .smu
        button.setTitleColor(.gray, for: .highlighted)
        return button
    }()
    
    let chatTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(red: 0, green: 0, blue: 0.5, alpha: 0.2)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    let keyboardView: UIView = {
        let uiView = UIView()
        return uiView
    }()
    
    let backBarButtonItem: UIBarButtonItem = {
        let barbutton = UIBarButtonItem(title: "Back",
                                                                style: .done,
                                                                 target: self,
                                                                 action: nil)
        return barbutton
    }()
    
    var keyboardHeightAnchor: NSLayoutConstraint?
    
    
    // MARK: - Lifecycles
    
    init(dependency: Dependency, payload: ()) {
        self.viewModel = dependency.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func subscribe() {
        let result = sendButton.rx.tap.asDriver()
            .flatMapLatest { [unowned self] in
                self.viewModel.responseDjango(sendText: self.chatTextField.text ?? "")
                    .asDriver(onErrorJustReturn: "Error !!!!!")
            }
           
        
//        TODO: - 테이블뷰에 채팅 뷰 넣기.
//        result
//            .drive(chatTableView.rx.text)
//            .disposed(by: disposeBag)
      
        
        backBarButtonItem.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.navigationController?.navigationBar.isHidden = true
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        let keyboardWillShowNotiObservable = NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillShowNotification)
            .map { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0}
        let keyboardWillHideNotiObservable = NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillHideNotification)
            .map { notification -> CGFloat in 0 }
        
        Observable.merge(keyboardWillShowNotiObservable, keyboardWillHideNotiObservable)
            .subscribe(onNext: { [weak self] height in
                UIView.animate(withDuration: 0.3) {
                    if height == 0 {
                        self?.keyboardHeightAnchor?.isActive = false
                        self?.keyboardHeightAnchor = self?.keyboardView.topAnchor.constraint(equalTo: (self?.keyboardView.bottomAnchor)!, constant: 0)
                        self?.keyboardHeightAnchor?.isActive = true
                    } else {
                        self?.keyboardHeightAnchor?.isActive = false
                        self?.keyboardHeightAnchor = self?.keyboardView.topAnchor.constraint(equalTo: (self?.keyboardView.bottomAnchor)!, constant: -height + (self?.view.safeAreaInsets.bottom ?? 0))
                        self?.keyboardHeightAnchor?.isActive = true
                    }
                    self?.view.layoutIfNeeded()
                }
            })
            .disposed(by: disposeBag)
    }

    
    // MARK: - Configures
    override func configureUI() {
        
        
        view.backgroundColor = .white
    
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.leftBarButtonItem = backBarButtonItem
//        self.navigationController?.navigationBar.backgroundColor = .smu
        
        view.initAutoLayout(UIViews: [chatTableView, chatTextField, sendButton, keyboardView])
        keyboardHeightAnchor = keyboardView.heightAnchor.constraint(equalToConstant: 0)
        keyboardHeightAnchor?.isActive = true
        NSLayoutConstraint.activate([
             
            chatTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            chatTextField.bottomAnchor.constraint(equalTo: sendButton.bottomAnchor),
            chatTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -5),
            chatTextField.heightAnchor.constraint(equalTo: sendButton.heightAnchor),
            
            sendButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            sendButton.bottomAnchor.constraint(equalTo: keyboardView.topAnchor, constant: -5),
            sendButton.widthAnchor.constraint(equalToConstant: 40),
            sendButton.heightAnchor.constraint(equalToConstant: 30),
            
            chatTableView.topAnchor.constraint(equalTo: view.topAnchor),
            chatTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chatTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chatTableView.bottomAnchor.constraint(equalTo: sendButton.topAnchor, constant: -5),
            
            keyboardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
        ])
    }
}
