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
    let characterImageView: UIImageView = {
        let uiImageView = UIImageView(image: UIImage(named: "testImage"))
        uiImageView.clipsToBounds = true
        return uiImageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        characterImageView.layer.cornerRadius = characterImageView.frame.width / 2
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
            contentView.initAutoLayout(UIViews: [characterImageView])
            
            characterImageView.topAnchor.constraint(equalTo: chatBubbleView.topAnchor).isActive = true
            characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
            characterImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
            characterImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
            
            chatBubbleView.backgroundColor = .white
            chatBubbleView.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 10).isActive = true
            chatBubbleView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -60).isActive = true
            
            
        }
    }
    
}
