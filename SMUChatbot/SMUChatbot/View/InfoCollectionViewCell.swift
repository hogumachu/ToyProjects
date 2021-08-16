import UIKit
import SnapKit

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
        
        titleLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        
        detailLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.left.right.equalTo(titleLabel)
        }
        
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(frame.width / 3)
            $0.centerY.equalToSuperview().offset(frame.height / 5)
            $0.width.height.equalTo(300)
        }
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

