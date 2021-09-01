import UIKit
import SnapKit
import RxSwift

class ChatTableViewCellRight: UITableViewCell {
    static let identifier = "ChatTableViewCellRight"
    let disposeBag = DisposeBag()
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configureUI() {
        chatLabel.font = .systemFont(ofSize: 15)
        chatLabel.textColor = .black
        chatLabel.numberOfLines = 0
        chatLabel.lineBreakMode = .byWordWrapping
        chatLabel.backgroundColor = .clear
        chatBubbleView.backgroundColor = .yellow
        
        backgroundColor = .clear
        contentView.initAutoLayout(UIViews: [chatBubbleView, chatLabel])
        
        chatLabel.snp.makeConstraints {
            $0.top.equalTo(chatBubbleView).offset(5)
            $0.leading.equalTo(chatBubbleView).offset(8)
            $0.trailing.equalTo(chatBubbleView).offset(-8)
        }
        
        contentView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(chatBubbleView.snp.height).offset(10)
        }
        
        chatBubbleView.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.bottom.equalTo(chatLabel.snp.bottom).offset(5)
            $0.leading.greaterThanOrEqualTo(snp.leading).offset(60)
            $0.trailing.equalTo(snp.trailing).offset(-10)
        }
    }
    
}
