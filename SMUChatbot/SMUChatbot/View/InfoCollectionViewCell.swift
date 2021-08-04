import UIKit

class InfoCollectionViewCell: UICollectionViewCell {
    static let identifier = "InfoCollectionViewCell"
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .white
        return label
    }()
    
    var detail: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        contentView.initAutoLayout(UIViews: [titleLabel])
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.smu.cgColor
        backgroundColor = .white
        titleLabel.textColor = .black
    }
}
