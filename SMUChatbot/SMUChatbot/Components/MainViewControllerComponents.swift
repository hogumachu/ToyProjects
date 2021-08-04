import UIKit

class SmuLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        text = "상명대학교"
        textColor = .smu
        textAlignment = .left
        font = .systemFont(ofSize: 70, weight: .heavy)
        adjustsFontSizeToFitWidth = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CapstoneLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        text = "캡스톤디자인"
        textColor = .smu
        textAlignment = .left
        font = .systemFont(ofSize: 70, weight: .heavy)
        adjustsFontSizeToFitWidth = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TeamNameLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        text = "채팅해조"
        textColor = .smu
        textAlignment = .left
        font = .systemFont(ofSize: 70, weight: .heavy)
        adjustsFontSizeToFitWidth = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
