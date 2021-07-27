//
//  ChatViewController.swift
//  SMUChatbot
//
//  Created by 홍성준 on 2021/07/21.
// 

import UIKit
import RxSwift
import RxCocoa

class ChatViewController: UIViewController {
    let model = Model()
    var disposeBag = DisposeBag()
    
    let mainViewButton: UIButton = {
        let button = UIButton()
        button.setTitle("Main", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 40)
        button.setTitleColor(.smu, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.addTarget(self, action: #selector(gotoMainVCAction(sender:)), for: .touchUpInside)
        return button
    }()
    
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
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .smu
        button.setTitleColor(.gray, for: .highlighted)
        return button
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.textColor = .white
        textView.backgroundColor = .smu
        textView.text = "init"
        textView.font = .systemFont(ofSize: 20)
        return textView
    }()
    
    
    @objc func gotoMainVCAction(sender: UIButton) {
        let mainVC = MainViewController()
        mainVC.modalPresentationStyle = .fullScreen
        mainVC.modalTransitionStyle = .flipHorizontal
        self.present(mainVC, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setConstraints()
        let result = sendButton.rx.tap.asDriver()
            .flatMapLatest {
                self.model.responseDjango(sendText: self.chatTextField.text ?? "")
                    .asDriver(onErrorJustReturn: "Error !!!!!")
            }
        
        result
            .drive(textView.rx.text)
            .disposed(by: disposeBag)
        
//        keyboardHeight()
//            .subscribe(onNext: { [weak self] height in
//                UIView.animate(withDuration: 0.3) {
//                    self?.textView.contentInset.bottom = height
//                }
//
//            })
//            .disposed(by: disposeBag)
        
        let keyboardWillShowNotiObservable = NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
            .map { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0}
        let keyboardWillHideNotiObservable = NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
            .map { notification -> CGFloat in 0}

        Observable.merge(keyboardWillShowNotiObservable, keyboardWillHideNotiObservable)
            .map { [unowned self] height -> UIEdgeInsets in
                var inset = self.textView.contentInset
                inset.bottom = height
                return inset
            }
            .subscribe(onNext: { [weak self] inset in
                print(inset)
                print(inset.bottom)
                self?.textView.contentInset = inset
                UIView.animate(withDuration: 0.3) {
                    self?.textView.layoutIfNeeded()
                }
            })
            .disposed(by: disposeBag)
        
        
    }
    
    func setConstraints() {
        textView.initAutoLayout(UIViews: [chatTextField, sendButton])
        view.initAutoLayout(UIViews: [mainViewButton, textView])
        NSLayoutConstraint.activate([
            mainViewButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            mainViewButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            
            chatTextField.leadingAnchor.constraint(equalTo: textView.layoutMarginsGuide.leadingAnchor),
            chatTextField.bottomAnchor.constraint(equalTo: textView.layoutMarginsGuide.bottomAnchor),
            chatTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -5),
            chatTextField.heightAnchor.constraint(equalTo: sendButton.heightAnchor),
            
            sendButton.trailingAnchor.constraint(equalTo: textView.layoutMarginsGuide.trailingAnchor),
            sendButton.bottomAnchor.constraint(equalTo: textView.layoutMarginsGuide.bottomAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 60),
            sendButton.heightAnchor.constraint(equalToConstant: 40),
            
            textView.topAnchor.constraint(equalTo: mainViewButton.bottomAnchor, constant: 10),
            textView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    func keyboardHeight() -> Observable<CGFloat> {
        return Observable
                .from([
                    NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
                                .map { notification -> CGFloat in
                                    (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
                                },
                        NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
                                .map { _ -> CGFloat in
                                    0
                                }
                ])
                .merge()
    }
}
