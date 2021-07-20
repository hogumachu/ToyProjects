//
//  MyProfileViewController.swift
//  HogumachuTalk
//
//  Created by 홍성준 on 2021/07/19.
//

import UIKit

import UIKit

class MyProfileViewController: UIViewController {
    let closeButton = UIButton()
    let topView = UIView()
    let bottomView = UIView()
    let profileImageView = UIImageView()
    let backgroundImageView = UIImageView()
    let nameLabel = UILabel()
    let statusLabel = UILabel()
    let horizontalStackView = UIStackView()
    let chatView = UIView()
    let editView = UIView()
    let instagramView = UIView()
    let chatImageView = UIImageView()
    let chatLabel = UILabel()
    let editImageView = UIImageView()
    let editLabel = UILabel()
    let instagramImageView = UIImageView()
    let instagramLabel = UILabel()
    let instagramButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        draw()
    }
    
    @objc func cancelButtonAction(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func goInstagram(sender: UIButton) {
        let instagramVC = InstagramViewController()
        instagramVC.modalPresentationStyle = .fullScreen
        self.present(instagramVC, animated: true)
    }
    
    func draw() {
        addViews()
        setViews()
        setConstraints()
    }
    
    
    
    func addViews() {
        view.addSubViews(UIViews: [
            backgroundImageView,
            bottomView.addSubViewAndReturnSelf(UIView:
                                                horizontalStackView.addSubViewsAndReturnSelf(UIViews: [
                                                    chatView.addSubViewsAndReturnSelf(UIViews: [
                                                        chatImageView,
                                                        chatLabel
                                                    ]),
                                                    editView.addSubViewsAndReturnSelf(UIViews: [
                                                        editImageView,
                                                        editLabel
                                                    ]),
                                                    instagramView.addSubViewsAndReturnSelf(UIViews: [
                                                        instagramImageView,
                                                        instagramLabel,
                                                        instagramButton
                                                    ])
                                                ])),
            topView.addSubViewsAndReturnSelf(UIViews: [
                closeButton,
                profileImageView,
                nameLabel,
                statusLabel,
            ]),
        ])
    }
    
    func setViews() {
        backgroundImageView.backgroundColor = .systemGray
        
        bottomView.layer.borderWidth = 1
        bottomView.layer.borderColor = UIColor.white.cgColor
        
        closeButton.setImage(UIImage(named: "close"), for: .normal)
        closeButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        
        profileImageView.image = UIImage(named: "profile")
        profileImageView.backgroundColor = .systemPink
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 20
        
        nameLabel.text = "Hogumachu"
        nameLabel.textColor = .white
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        nameLabel.textAlignment = .center
        
        statusLabel.text = "Nice To Meet You"
        statusLabel.textColor = .white
        statusLabel.textAlignment = .center
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.alignment = .fill
        horizontalStackView.contentMode = .scaleToFill
        
        chatImageView.image = UIImage(named: "chat")
        chatImageView.contentMode = .scaleAspectFit
        
        chatLabel.text = "나와의 채팅"
        chatLabel.textColor = .white
        chatLabel.textAlignment = .center
        
        editImageView.image = UIImage(named: "edit")
        editImageView.contentMode = .scaleAspectFit
        
        editLabel.text = "프로필 편집"
        editLabel.textColor = .white
        editLabel.textAlignment = .center
        
        instagramImageView.image = UIImage(named: "insta")
        instagramImageView.contentMode = .scaleAspectFit
        
        instagramLabel.text = "인스타그램"
        instagramLabel.textColor = .white
        instagramLabel.textAlignment = .center
        
        instagramButton.setTitle("", for: .normal)
        instagramButton.addTarget(self, action: #selector(goInstagram(sender:)), for: .touchUpInside)
    }
    
    func setConstraints() {
        translatesAutoresizingMaskIntoConstraints(UIViews:[
                                                    backgroundImageView, bottomView, topView, chatImageView, closeButton, profileImageView, nameLabel, statusLabel, horizontalStackView, chatView, editView, instagramView, chatLabel, editImageView, editLabel, instagramImageView, instagramLabel, instagramButton
        ])
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -1),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 1),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 1),
            bottomView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15),
            
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
    
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.bottomAnchor.constraint(equalTo: statusLabel.superview!.bottomAnchor, constant: -30),
            
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor, constant: -10),
            
            closeButton.topAnchor.constraint(equalTo: closeButton.superview!.topAnchor, constant: 10),
            closeButton.leadingAnchor.constraint(equalTo: closeButton.superview!.leadingAnchor, constant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 20),
            closeButton.heightAnchor.constraint(equalToConstant: 20),
            
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -10),
            profileImageView.heightAnchor.constraint(equalToConstant: 120),
            profileImageView.widthAnchor.constraint(equalToConstant: 120),
            
            horizontalStackView.centerXAnchor.constraint(equalTo: horizontalStackView.superview!.centerXAnchor),
            horizontalStackView.centerYAnchor.constraint(equalTo: horizontalStackView.superview!.centerYAnchor),
//            horizontalStackView.heightAnchor.constraint(equalTo: horizontalStackView.superview!.heightAnchor, multiplier: 2 / 3),
//            heightAnchor는 changehorizontalStackViewHeight() 에서 대체
            horizontalStackView.widthAnchor.constraint(equalTo: horizontalStackView.superview!.widthAnchor, multiplier: 4 / 5),
            
            chatView.topAnchor.constraint(equalTo: chatView.superview!.topAnchor),
            chatView.leadingAnchor.constraint(equalTo: chatView.superview!.leadingAnchor),
            chatView.widthAnchor.constraint(equalTo: chatView.superview!.widthAnchor, multiplier: 1 / 3),
            chatView.bottomAnchor.constraint(equalTo: chatView.superview!.bottomAnchor),
            
            editView.topAnchor.constraint(equalTo: editView.superview!.topAnchor),
            editView.leadingAnchor.constraint(equalTo: chatView.trailingAnchor),
            editView.widthAnchor.constraint(equalTo: chatView.widthAnchor),
            editView.bottomAnchor.constraint(equalTo: editView.superview!.bottomAnchor),
            
            instagramView.topAnchor.constraint(equalTo: instagramView.superview!.topAnchor),
            instagramView.leadingAnchor.constraint(equalTo: editView.trailingAnchor),
            instagramView.widthAnchor.constraint(equalTo: chatView.widthAnchor),
            instagramView.bottomAnchor.constraint(equalTo: instagramView.superview!.bottomAnchor),
            
            chatImageView.topAnchor.constraint(equalTo: chatImageView.superview!.topAnchor),
            chatImageView.leadingAnchor.constraint(equalTo: chatImageView.superview!.leadingAnchor),
            chatImageView.trailingAnchor.constraint(equalTo: chatImageView.superview!.trailingAnchor),
            chatImageView.bottomAnchor.constraint(lessThanOrEqualTo: chatLabel.topAnchor, constant: -5),
            
            chatLabel.leadingAnchor.constraint(equalTo: chatLabel.superview!.leadingAnchor),
            chatLabel.trailingAnchor.constraint(equalTo: chatLabel.superview!.trailingAnchor),
            chatLabel.bottomAnchor.constraint(equalTo: chatLabel.superview!.bottomAnchor),
            chatLabel.heightAnchor.constraint(equalTo: chatLabel.superview!.heightAnchor, multiplier: 1 / 3),
            
            editImageView.topAnchor.constraint(equalTo: editImageView.superview!.topAnchor),
            editImageView.leadingAnchor.constraint(equalTo: editImageView.superview!.leadingAnchor),
            editImageView.trailingAnchor.constraint(equalTo: editImageView.superview!.trailingAnchor),
            editImageView.bottomAnchor.constraint(lessThanOrEqualTo: editLabel.topAnchor, constant: -5),
            
            editLabel.leadingAnchor.constraint(equalTo: editLabel.superview!.leadingAnchor),
            editLabel.trailingAnchor.constraint(equalTo: editLabel.superview!.trailingAnchor),
            editLabel.bottomAnchor.constraint(equalTo: editLabel.superview!.bottomAnchor),
            editLabel.heightAnchor.constraint(equalTo: editLabel.superview!.heightAnchor, multiplier: 1 / 3),
            
            instagramImageView.topAnchor.constraint(equalTo: instagramImageView.superview!.topAnchor),
            instagramImageView.leadingAnchor.constraint(equalTo: instagramImageView.superview!.leadingAnchor),
            instagramImageView.trailingAnchor.constraint(equalTo: instagramImageView.superview!.trailingAnchor),
            instagramImageView.bottomAnchor.constraint(lessThanOrEqualTo: instagramLabel.topAnchor, constant: -5),
            
            instagramLabel.leadingAnchor.constraint(equalTo: instagramLabel.superview!.leadingAnchor),
            instagramLabel.trailingAnchor.constraint(equalTo: instagramLabel.superview!.trailingAnchor),
            instagramLabel.bottomAnchor.constraint(equalTo: instagramLabel.superview!.bottomAnchor),
            instagramLabel.heightAnchor.constraint(equalTo: instagramLabel.superview!.heightAnchor, multiplier: 1 / 3),
            
            instagramButton.topAnchor.constraint(equalTo: instagramView.topAnchor),
            instagramButton.leadingAnchor.constraint(equalTo: instagramView.leadingAnchor),
            instagramButton.trailingAnchor.constraint(equalTo: instagramView.trailingAnchor),
            instagramButton.bottomAnchor.constraint(equalTo: instagramView.bottomAnchor),
        ])
        
        changehorizontalStackViewHeight()
        
        if #available(iOS 11.0, *) {
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        }
    }
    
    
}






extension MyProfileViewController {
//    Device가 가로인지 세로인지 판단하여 horizontalStackView의 height를 변경함
    func changehorizontalStackViewHeight() {
        if UIDevice.current.orientation.isLandscape {
            horizontalStackView.heightAnchor.constraint(equalTo: horizontalStackView.superview!.heightAnchor, multiplier: 2 / 3).isActive = true
        } else {
            horizontalStackView.heightAnchor.constraint(equalTo: horizontalStackView.superview!.heightAnchor, multiplier: 1 / 3).isActive = true
        }
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        changehorizontalStackViewHeight()
    }
}

