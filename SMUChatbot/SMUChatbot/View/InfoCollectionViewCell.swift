import UIKit

class InfoCollectionViewCell: UICollectionViewCell {
    static let identifier = "InfoCollectionViewCell"
    
    let titleLabel = HeavyTitleLabel()
    
    let detailLabel = DetailLabel()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPink
        imageView.transform = imageView.transform.rotated(by: .pi / 8)
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        imageView.layer.shadowRadius = 10
        imageView.layer.shadowOpacity = 0.3
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        backgroundColor = .smu
        layer.cornerRadius = 15
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 10
        layer.shadowOpacity = 1
//        clipsToBounds = true
        layer.masksToBounds = false
        
        titleLabel.textColor = .white
        
        contentView.initAutoLayout(UIViews: [titleLabel, detailLabel, imageView])
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            
            detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            detailLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            detailLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),
            
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: frame.width / 3),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: frame.height / 5),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
}
