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
        label.textColor = .smu
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 70, weight: .heavy)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let capstoneLabel: UILabel = {
        let label = UILabel()
        label.text = "캡스톤디자인"
        label.textColor = .smu
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 70, weight: .heavy)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let teamNameLabel: UILabel = {
        let label = UILabel()
        label.text = "채팅해조"
        label.textColor = .smu
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 70, weight: .heavy)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    func animateAndGoInfoVC() {
        UIView.transition(with: self.smuLabel, duration: 1, options: .transitionCrossDissolve) {
            self.smuLabel.textColor = .white
        } completion: { _ in
            UIView.transition(with: self.capstoneLabel, duration: 1, options: .transitionCrossDissolve) {
                self.capstoneLabel.textColor = .white
            } completion: { _ in
                UIView.transition(with: self.teamNameLabel, duration: 1, options: .transitionCrossDissolve) {
                    self.teamNameLabel.textColor = .white
                } completion: {  _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.goInfoVC()
                    }
                }
            }
        }
    }
    
    func goInfoVC() {
        let infoVC = InfoViewController()
        infoVC.modalPresentationStyle = .fullScreen
        infoVC.modalTransitionStyle = .crossDissolve
        self.present(infoVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateAndGoInfoVC()
        
    }
    func setConstraints() {
        view.backgroundColor = .smu
        view.initAutoLayout(UIViews: [smuLabel, capstoneLabel, teamNameLabel])
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
            
        ])
    }
    
    


}


extension UIColor {
    static let smu = UIColor(red: 0, green: 0.149, blue: 0.5686, alpha: 1.0)
}
