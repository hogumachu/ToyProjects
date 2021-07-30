//
//  MainViewController.swift
//  SMUChatbot
//
//  Created by 홍성준 on 2021/07/21.
//

import UIKit

class MainViewController: UIViewController {
    var viewModel = MainViewModel()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel.gotoInfoVCAfterAnimate([smuLabel, capstoneLabel, teamNameLabel], self)
        
    }
    func setView() {
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


