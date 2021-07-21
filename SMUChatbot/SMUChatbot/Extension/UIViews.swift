//
//  UIViews.swift
//  SMUChatbot
//
//  Created by 홍성준 on 2021/07/21.
//

import UIKit

extension UIView {
    func initAutoLayout(UIViews: [UIView]) {
        UIViews.forEach({ UIView in
            UIView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(UIView)
        })
    }
    
}
