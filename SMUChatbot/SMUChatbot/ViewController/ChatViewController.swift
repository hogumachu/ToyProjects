import UIKit
import RxSwift
import RxCocoa

class ChatViewController: BaseViewController {
    struct Dependency {
        let viewModel: ChatViewModel
    }
    
    // MARK: - Properties
    
    let viewModel: ChatViewModel
    let chatTextField = ChatTextField()
    let sendButton = SendButton()
    let chatTableView = ChatTableView()
    let keyboardView = UIView()
    let backBarButtonItem = BackBarButtonItem()
    var keyboardHeightAnchor: NSLayoutConstraint?
    
    // MARK: - Lifecycles
    
    init(dependency: Dependency, payload: ()) {
        self.viewModel = dependency.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        resignFirstResponder()
        super.viewWillAppear(animated)
    }
    
    // MARK: - Configures
    
    override func configureUI() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        
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
    
    // MARK: - Subscribes
    
    override func subscribe() {
        
        viewModel.sendMessage
            .subscribe { event in
                if let text = event.element {
                    print("SendMessage:", text)
                }
            }.disposed(by: disposeBag)
        
        viewModel.receiveMessage
            .subscribe { event in
                if let text = event.element {
                    print("ReceiveMessage:", text)
                }
            }.disposed(by: disposeBag)
        
        
        sendButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                if let text = self.chatTextField.text, text != "" {
                    self.viewModel.chatting(sendText: self.chatTextField.text ?? "")
                    self.chatTextField.text = ""
                }
            }).disposed(by: disposeBag)
        
//        TODO: - 테이블뷰에 채팅 뷰 넣기.
//        let result = sendButton.rx.tap.asDriver()
//            .flatMapLatest { [unowned self] in
//                self.viewModel.responseDjango(sendText: self.chatTextField.text ?? "")
//                    .asDriver(onErrorJustReturn: "Error !!!!!")
//            }
//        result
//            .drive(chatTableView.rx.text)
//            .disposed(by: disposeBag)
        
        backBarButtonItem.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.navigationController?.navigationBar.isHidden = true
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        Observable.merge(viewModel.keyboardWillShowNotiObservable(), viewModel.keyboardWillHideNotiObservable())
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
}
