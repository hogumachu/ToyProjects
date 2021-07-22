//
//  ChatViewController.swift
//  SMUChatbot
//
//  Created by 홍성준 on 2021/07/21.
//

import UIKit
import RxSwift

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
        textField.addTarget(self, action: #selector(sendMessageAciton(sender:)), for: .touchDragEnter)
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
        button.addTarget(self, action: #selector(sendMessageAciton(sender:)), for: .touchUpInside)
        return button
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.textColor = .blue
        return textView
    }()
    
    
    @objc func gotoMainVCAction(sender: UIButton) {
        let mainVC = MainViewController()
        mainVC.modalPresentationStyle = .fullScreen
        mainVC.modalTransitionStyle = .flipHorizontal
        self.present(mainVC, animated: true, completion: nil)
    }
    
    @objc func sendMessageAciton(sender: UIButton) {
        guard let text = chatTextField.text else {
            return
        }
        model.responseDjango(sendText: text)
//        어떻게 model 에 text 를 보내고 그것을 어떻게 받아올 것 인가.
        
        
        chatTextField.text = ""
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setConstraints()
    }
    
    func setConstraints() {
        view.initAutoLayout(UIViews: [mainViewButton, chatTextField, sendButton, textView])
        NSLayoutConstraint.activate([
            mainViewButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            mainViewButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            
            chatTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            chatTextField.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            chatTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -5),
            chatTextField.heightAnchor.constraint(equalTo: sendButton.heightAnchor),
            
            sendButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            sendButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 60),
            sendButton.heightAnchor.constraint(equalToConstant: 40),
            
            textView.topAnchor.constraint(equalTo: mainViewButton.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: sendButton.topAnchor)
        ])
    }
    

}
