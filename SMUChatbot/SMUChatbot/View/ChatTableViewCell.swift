import UIKit

class ChatTableViewCell: UITableViewCell {
    static let identifier = "ChatTableViewCell"
    let chatLabel = DetailLabel()
    
    
    func configureUI() {
        chatLabel.numberOfLines = 0
        chatLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        chatLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    }
}
