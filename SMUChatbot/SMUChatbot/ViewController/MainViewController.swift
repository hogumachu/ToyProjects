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
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 70, weight: .heavy)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let capstoneLabel: UILabel = {
        let label = UILabel()
        label.text = "캡스톤디자인"
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 70, weight: .heavy)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let teamNameLabel: UILabel = {
        let label = UILabel()
        label.text = "채팅해조"
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 70, weight: .heavy)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let startButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Start ", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 40, weight: .heavy)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(goChatVC(sender:)), for: .touchUpInside)
        
        return button
    }()
    
    let infoButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Info ", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 40, weight: .heavy)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
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
        view.backgroundColor = .smu
        view.initAutoLayout(UIViews: [smuLabel, capstoneLabel, teamNameLabel, startButton, infoButton])
        NSLayoutConstraint.activate([
            smuLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            smuLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            smuLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            capstoneLabel.topAnchor.constraint(equalTo: smuLabel.bottomAnchor, constant: 5),
            capstoneLabel.leadingAnchor.constraint(equalTo: smuLabel.leadingAnchor),
            capstoneLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            teamNameLabel.topAnchor.constraint(equalTo: capstoneLabel.bottomAnchor, constant: 5),
            teamNameLabel.leadingAnchor.constraint(equalTo: capstoneLabel.leadingAnchor),
            teamNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            startButton.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 3 / 5),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            infoButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 30),
            infoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }


}


extension UIColor {
    static let smu = UIColor(red: 0, green: 0.149, blue: 0.5686, alpha: 1.0)
}
