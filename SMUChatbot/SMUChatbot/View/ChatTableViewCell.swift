import UIKit

class ChatTableViewCell: UITableViewCell {
    static let identifier = "ChatTableViewCell"
    let chatLabel = DetailLabel()
    let chatBubbleView: UIView = {
        let uiView = UIView()
        uiView.layer.masksToBounds = true
        uiView.layer.cornerRadius = 8
        return uiView
    }()
    
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
        chatLabel.backgroundColor = .clear
        
        backgroundColor = .clear
        contentView.initAutoLayout(UIViews: [chatBubbleView, chatLabel])
        
        
        chatBubbleView.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        chatBubbleView.bottomAnchor.constraint(equalTo: chatLabel.bottomAnchor, constant: 5).isActive = true
        
        chatLabel.topAnchor.constraint(equalTo: chatBubbleView.topAnchor, constant: 5).isActive = true
        chatLabel.leadingAnchor.constraint(equalTo: chatBubbleView.leadingAnchor, constant: 8).isActive = true
        chatLabel.trailingAnchor.constraint(equalTo: chatBubbleView.trailingAnchor, constant: -8).isActive = true
        
        contentView.heightAnchor.constraint(equalTo: chatLabel.heightAnchor, constant: 10).isActive = true
    }
    
    func isSender(_ compare: Bool) {
        if compare {
            chatBubbleView.backgroundColor = .yellow
            chatBubbleView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 60).isActive = true
            chatBubbleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        } else {
            chatBubbleView.backgroundColor = .white
            chatBubbleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
            chatBubbleView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -60).isActive = true
        }
    }
    
}
