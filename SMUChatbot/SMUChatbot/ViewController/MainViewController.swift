//
//  MainViewController.swift
//  SMUChatbot
//
//  Created by 홍성준 on 2021/07/21.
//

import UIKit

class MainViewController: UIViewController {
    
    let smuLabel: UILabel = {
        let label = UILabel()
        label.text = "상명대학교"
        label.textColor = .black
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 70)
        return label
    }()
    
    let capstoneLabel: UILabel = {
        let label = UILabel()
        label.text = "캡스톤디자인"
        label.textColor = .black
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 70)
        return label
    }()
    
    let teamNameLabel: UILabel = {
        let label = UILabel()
        label.text = "채팅해조"
        label.textColor = .black
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 70)
        return label
    }()
    
    let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 50)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(goChatVC(sender:)), for: .touchUpInside)
        
        return button
    }()
    
    let infoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Info", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 50)
        button.setTitleColor(.systemPink, for: .normal)
        button.addTarget(self, action: #selector(goInfoVC(sender:)), for: .touchUpInside)
        
        return button
    }()
    
    @objc func goChatVC(sender: UIButton) {
        let chatVC = ChatViewController()
        chatVC.modalPresentationStyle = .fullScreen
        chatVC.modalTransitionStyle = .flipHorizontal
        self.present(chatVC, animated: true)
    }
    
    @objc func goInfoVC(sender: UIButton) {
        let infoVC = InfoViewController()
        infoVC.modalPresentationStyle = .fullScreen
        infoVC.modalTransitionStyle = .crossDissolve
        self.present(infoVC, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
    }
    
    func setConstraints() {
        view.backgroundColor = .white
        view.initAutoLayout(UIViews: [smuLabel, capstoneLabel, teamNameLabel, startButton, infoButton])
        NSLayoutConstraint.activate([
            smuLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            smuLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            
            capstoneLabel.topAnchor.constraint(equalTo: smuLabel.bottomAnchor, constant: 5),
            capstoneLabel.leadingAnchor.constraint(equalTo: smuLabel.leadingAnchor),
            
            teamNameLabel.topAnchor.constraint(equalTo: capstoneLabel.bottomAnchor, constant: 5),
            teamNameLabel.leadingAnchor.constraint(equalTo: capstoneLabel.leadingAnchor),
            
            startButton.topAnchor.constraint(equalTo: teamNameLabel.bottomAnchor),
            startButton.leadingAnchor.constraint(equalTo: teamNameLabel.leadingAnchor),
            
            infoButton.topAnchor.constraint(equalTo: startButton.bottomAnchor),
            infoButton.leadingAnchor.constraint(equalTo: startButton.leadingAnchor),
        ])
    }


}

