//
//  MainViewModel.swift
//  SMUChatbot
//
//  Created by 홍성준 on 2021/07/30.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewModel {
    func gotoInfoVC(_ vc: UIViewController) {
        guard let nav = vc.navigationController else {
            print("Error")
            return
        }
        let infoVC = InfoViewController()
        infoVC.modalPresentationStyle = .fullScreen
        infoVC.modalTransitionStyle = .crossDissolve
        nav.pushViewController(infoVC, animated: true)
    }
    
    func gotoInfoVCAfterAnimate(_ labels: [UILabel], _ vc: UIViewController) {
        var timeInterval = 0.5
        
        labels.forEach { label in
            DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval) {
                UIView.transition(with: label, duration: 0.5, options: .transitionCrossDissolve) {
                    label.textColor = .white
                }
            }
            timeInterval += 0.5
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.gotoInfoVC(vc)
        }
    }
}
