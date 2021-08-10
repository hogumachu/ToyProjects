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
        contentView.initAutoLayout(UIViews: [chatLabel])
        chatLabel.textColor = .black
        backgroundColor = .clear
        chatLabel.numberOfLines = 0
        
        chatLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        chatLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        chatLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 10).isActive = true
    }
}
