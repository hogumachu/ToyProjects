import UIKit
import SnapKit

class SearchTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "SearchTableViewCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    let address: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 13)
        label.textColor = .systemGray
        return label
    }()
    let telephon: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    // MARK: - Lifecycles
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    // MARK: - Configures
    func configureUI() {
        addSubviews(titleLabel, address, telephon)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide).offset(4)
            $0.top.leading.trailing.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        address.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.trailing.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        telephon.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.top.equalTo(address.snp.bottom)
            $0.trailing.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
}
