//
//  FriendTableViewCell.swift
//  HogumachuTalk
//
//  Created by 홍성준 on 2021/07/08.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
//    Call Profile, Name from Model
    private var profile: UIImageView! = UIImageView()
    private var name: UILabel! = UILabel()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        Padding Cell
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10))
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraint() {
        contentView.addSubview(profile)
        contentView.addSubview(name)
        profile.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profile.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            profile.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profile.topAnchor.constraint(equalTo: contentView.topAnchor),
            profile.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            profile.widthAnchor.constraint(equalToConstant: 40),
            profile.heightAnchor.constraint(equalToConstant: 50),
            
            name.leadingAnchor.constraint(equalTo: profile.trailingAnchor, constant: 10),
            name.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
        ])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
