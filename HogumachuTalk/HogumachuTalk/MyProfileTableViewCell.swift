//
//  MyProfileTableViewCell.swift
//  HogumachuTalk
//
//  Created by 홍성준 on 2021/07/08.
//

import UIKit

class MyProfileTableViewCell: UITableViewCell {
    private var name: UILabel! = UILabel()
    private var profile: UIImageView! = UIImageView()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
            profile.widthAnchor.constraint(equalToConstant: 30),
            profile.heightAnchor.constraint(equalToConstant: 40),
            
            name.leadingAnchor.constraint(equalTo: profile.trailingAnchor, constant: 10),
            name.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
        ])
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
