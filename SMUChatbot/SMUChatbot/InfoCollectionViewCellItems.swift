//
//  InfoCollectionViewCell.swift
//  SMUChatbot
//
//  Created by 홍성준 on 2021/07/21.
//

import UIKit

struct InfoCollectionViewCellItems {
    let index: Int
    let button: UIButton?
    let backgroundColor: UIColor
    
    static func getInfoViewCellItems() ->[InfoCollectionViewCellItems] {
        let first = InfoCollectionViewCellItems(index: 0,
                                                button: {
                                                    let button = UIButton()
                                                    button.setTitle("Back", for: .normal)
                                                    button.titleLabel?.font = .boldSystemFont(ofSize: 40)
                                                    button.setTitleColor(.black, for: .normal)
                                                    return button
                                                }(),
                                                backgroundColor: .systemPink)
        let second = InfoCollectionViewCellItems(index: 1,
                                                 button: nil,
                                                backgroundColor: .cyan)
        let third = InfoCollectionViewCellItems(index: 2,
                                                button: {
                                                    let button = UIButton()
                                                    button.setTitle("Forward", for: .normal)
                                                    button.titleLabel?.font = .boldSystemFont(ofSize: 40)
                                                    button.setTitleColor(.black, for: .normal)
                                                    return button
                                                }(),
                                                backgroundColor: .brown)
        return [first, second, third]
    }
    
    
}
