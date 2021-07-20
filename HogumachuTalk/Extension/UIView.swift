//
//  UIView.swift
//  HogumachuTalk
//
//  Created by 홍성준 on 2021/07/20.
//

import UIKit

extension UIView {
    func addSubViews(UIViews: [UIView]) {
        UIViews.forEach({ UIView in
            self.addSubview(UIView)
        })
    }
    
    func addSubViewsAndReturnSelf(UIViews: [UIView]) -> UIView {
        UIViews.forEach({ UIView in
            self.addSubview(UIView)
        })
        return self
    }
    
    func addSubViewAndReturnSelf(UIView: UIView) -> UIView {
        self.addSubview(UIView)
        return self
    }
}

func translatesAutoresizingMaskIntoConstraints(UIViews: [UIView]) {
    UIViews.forEach({ UIView in
        UIView.translatesAutoresizingMaskIntoConstraints = false
    })
}
