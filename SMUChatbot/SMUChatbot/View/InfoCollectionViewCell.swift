import UIKit

class InfoCollectionViewCell: UICollectionViewCell {
    static let identifier = "InfoCollectionViewCell"
    
    // MARK: - Properties
    
    let titleLabel = HeavyTitleLabel()
    let detailLabel = DetailLabel()
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPink
        imageView.transform = imageView.transform.rotated(by: .pi / 8)
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = false
        return imageView
    }()
    
    // MARK: - Lifecycles
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyShadows()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configures
    
    func configureUI() {
        backgroundColor = .smu
        layer.cornerRadius = 15
        
        // TODO: - clipsToBounds vs. masksToBounds 해결하기. Cell의 shadow 가 정상적으로 작동하도록.
        clipsToBounds = true
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
    
    func applyShadows() {
        // TODO: - Shadow Path 추가해도 잘 동작하게 하기.
//        imageView.layer.shadowPath = UIBezierPath(roundedRect: imageView.bounds, cornerRadius: 10).cgPath
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowRadius = 15
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowOffset = CGSize(width: 20, height: 0)
        imageView.layer.shouldRasterize = true
        imageView.layer.rasterizationScale = UIScreen.main.scale
    
    }
    
}

