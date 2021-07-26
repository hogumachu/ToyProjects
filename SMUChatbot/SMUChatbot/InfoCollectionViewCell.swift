//
//  InfoCollectionViewCell.swift
//  SMUChatbot
//
//  Created by 홍성준 on 2021/07/26.
//

import UIKit

class InfoCollectionViewCell: UICollectionViewCell {
    let summaryLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    var detail: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.initAutoLayout(UIViews: [summaryLabel])
//        = contentView.addsubview & UIViews.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            summaryLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            summaryLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
