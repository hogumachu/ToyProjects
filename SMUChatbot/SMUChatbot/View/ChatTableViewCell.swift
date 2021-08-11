import UIKit

class ChatTableViewCell: UITableViewCell {
    static let identifier = "ChatTableViewCell"
    let chatLabel = DetailLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        chatLabel.font = .systemFont(ofSize: 15)
        chatLabel.textColor = .black
        chatLabel.numberOfLines = 0
        chatLabel.lineBreakMode = .byWordWrapping
        chatLabel.layer.masksToBounds = true
        chatLabel.layer.cornerRadius = 5
        
        backgroundColor = .clear
        contentView.initAutoLayout(UIViews: [chatLabel])
        
        chatLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        contentView.heightAnchor.constraint(equalTo: chatLabel.heightAnchor, constant: 10).isActive = true
    }
    
    func isSender(_ compare: Bool) {
        if compare {
            chatLabel.textAlignment = .right
            chatLabel.backgroundColor = .yellow
            chatLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 10).isActive = true
            chatLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        } else {
            chatLabel.textAlignment = .left
            chatLabel.backgroundColor = .brown
            chatLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
            chatLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -10).isActive = true
        }
    }
    
}
