import UIKit
import SnapKit
import RxSwift

class ChatTableViewCell: UITableViewCell {
    static let identifier = "ChatTableViewCell"
    let disposeBag = DisposeBag()
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
        contentView.initAutoLayout(UIViews: [chatBubbleView, chatLabel, characterImageView])
        
        chatLabel.snp.makeConstraints {
            $0.top.equalTo(chatBubbleView).offset(5)
            $0.leading.equalTo(chatBubbleView).offset(8)
            $0.trailing.equalTo(chatBubbleView).offset(-8)
        }
        
        contentView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(chatLabel).offset(10)
        }
    }
    
    // ChatBubbleView Layout
    
    func isSender(_ compare: Bool) {
        if compare {
            print("노란색 채팅")
            chatBubbleView.backgroundColor = .yellow
            characterImageView.isHidden = true
            chatBubbleView.snp.remakeConstraints {
                $0.top.equalToSuperview().offset(15)
                $0.bottom.equalTo(chatLabel.snp.bottom).offset(5)
                $0.leading.greaterThanOrEqualTo(snp.leading).offset(60)
                $0.trailing.equalTo(snp.trailing).offset(-10)
            }
        } else {
            print("흰색 채팅")
            chatBubbleView.backgroundColor = .white
            characterImageView.isHidden = false
            chatBubbleView.snp.remakeConstraints {
                $0.top.equalToSuperview().offset(15)
                $0.bottom.equalTo(chatLabel.snp.bottom).offset(5)
                $0.leading.equalTo(characterImageView.snp.trailing).offset(10)
                $0.trailing.lessThanOrEqualTo(snp.trailing).offset(-60)
            }
            
            characterImageView.snp.makeConstraints {
                $0.top.equalTo(chatBubbleView)
                $0.leading.equalTo(snp.leading).offset(10)
                $0.width.height.equalTo(50)
            }
        }
    }
    
}
