import UIKit
import RxSwift
import RxCocoa
import RxKeyboard
import SnapKit

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
    let loadingIndicator = UIActivityIndicatorView()
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
        loadingIndicator.color = .purple
        
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        self.navigationItem.titleView = loadingIndicator
        
        chatTableView.register(ChatTableViewCell.self, forCellReuseIdentifier: ChatTableViewCell.identifier)
        
        view.initAutoLayout(UIViews: [chatTableView, chatTextField, sendButton, keyboardView])
        
        loadingIndicator.isHidden = true
        
        // keyboardHeightAnchor 에 대해서도 SnapKit 로 해봤는데 정상적으로 동작하지 않아 Anchor 로 진행하였음. 추후 수정하기.
        keyboardHeightAnchor = keyboardView.heightAnchor.constraint(equalToConstant: 0)
        keyboardHeightAnchor?.isActive = true
        
        
        chatTextField.snp.makeConstraints  {
            $0.leading.equalTo(view.layoutMarginsGuide)
            $0.bottom.height.equalTo(sendButton)
            $0.trailing.equalTo(sendButton.snp.leading).offset(-5)
        }
        
        sendButton.snp.makeConstraints {
            $0.trailing.equalTo(view.layoutMarginsGuide)
            $0.bottom.equalTo(keyboardView.snp.top).offset(-5)
            $0.width.equalTo(40)
            $0.height.equalTo(30)
        }
        
        chatTableView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view)
            $0.bottom.equalTo(sendButton.snp.top).offset(-5)
        }
        
        keyboardView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view)
            $0.bottom.equalTo(view.layoutMarginsGuide.snp.bottom)
        }
    }
    
    // MARK: - Subscribes
    
    override func subscribe() {
        viewModel.messageRelay.bind(to: chatTableView.rx.items(cellIdentifier: ChatTableViewCell.identifier, cellType: ChatTableViewCell.self)) {  index, item, cell in
            if item.text != "" {
                cell.chatLabel.text = item.text
                cell.isSender(item.isSender)
            } else {
                cell.chatLabel.text = " "
                cell.isSender(true)
                cell.chatBubbleView.backgroundColor = .clear
                self.scrollToBottom()
            }
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
        
        viewModel.loadingRelay
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] isLoading in
            if isLoading {
                loadingIndicator.isHidden = false
                loadingIndicator.startAnimating()
            } else {
                loadingIndicator.stopAnimating()
                loadingIndicator.isHidden = true
            }
        })
        .disposed(by: disposeBag)
        
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { keyboardVisibleHeight in
                self.keyboardHeightAnchor?.isActive = false
                self.keyboardHeightAnchor = self.keyboardView.topAnchor.constraint(equalTo: self.keyboardView.bottomAnchor, constant: -keyboardVisibleHeight + self.view.safeAreaInsets.bottom)
                self.keyboardHeightAnchor?.isActive = true
                self.view.layoutIfNeeded()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Helper
    
    func scrollToBottom() {
        guard !viewModel.messages.isEmpty else { return }
        DispatchQueue.main.async {
            self.chatTableView.scrollToRow(at: IndexPath(row: self.viewModel.messages.count - 1, section: 0), at: .bottom, animated: true)
        }
    }
}


extension ChatViewController: UIScrollViewDelegate { }
