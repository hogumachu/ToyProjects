import UIKit
import SnapKit

class RandomTableViewCell: UITableViewCell {
    static let identifier = "RandomTableViewCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .black
        return label
    }()
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 30
        view.layer.cornerCurve = .continuous
        view.backgroundColor = .systemPink
        return view
    }()
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5
        stack.distribution = .equalSpacing
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(cardView)
        cardView.addSubview(titleLabel)
    
        cardView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(10)
            $0.trailing.bottom.equalToSuperview().offset(-10)
            $0.height.equalTo(300)
        }
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
