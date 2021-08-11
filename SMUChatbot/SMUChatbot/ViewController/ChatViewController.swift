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
        
        chatTableView.register(ChatTableViewCell.self, forCellReuseIdentifier: ChatTableViewCell.identifier)
        
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
        viewModel.messageRelay.bind(to: chatTableView.rx.items(cellIdentifier: ChatTableViewCell.identifier, cellType: ChatTableViewCell.self)) { index, item, cell in
            cell.chatLabel.text = item.text
            cell.isSender(item.isSender)
        }.disposed(by: disposeBag)
        
        sendButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                if let text = self.chatTextField.text, text != "" {
                    self.viewModel.chatting(sendText: text)
                    self.chatTextField.text = ""
                }
            }).disposed(by: disposeBag)
        
        backBarButtonItem.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.navigationController?.navigationBar.isHidden = true
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        Observable.merge(viewModel.keyboardWillShowNotiObservable(), viewModel.keyboardWillHideNotiObservable())
            .asDriver(onErrorJustReturn: 0)
            .drive { height in
                UIView.animate(withDuration: 0.3) {
                    self.changeKeyboardHeight(height)
                }
            }
            .disposed(by: disposeBag)
        
    }
    
    // MARK: - Helper
    
    func changeKeyboardHeight(_ height: CGFloat) {
        if height == 0 {
            self.keyboardHeightAnchor?.isActive = false
            self.keyboardHeightAnchor = self.keyboardView.topAnchor.constraint(equalTo: self.keyboardView.bottomAnchor, constant: 0)
            self.keyboardHeightAnchor?.isActive = true
        } else {
            self.keyboardHeightAnchor?.isActive = false
            self.keyboardHeightAnchor = self.keyboardView.topAnchor.constraint(equalTo: self.keyboardView.bottomAnchor, constant: -height + self.view.safeAreaInsets.bottom)
            self.keyboardHeightAnchor?.isActive = true
        }
        self.view.layoutIfNeeded()
    }
}


extension ChatViewController: UIScrollViewDelegate { }
