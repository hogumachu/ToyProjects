import UIKit

class MovieListTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "MovieListTableViewCell"
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .init(name: "Georgia Italic", size: 20)
        label.textColor = .white
        return label
    }()
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .init(name: "Georgia Italic", size: 20)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.layer.cornerCurve = .continuous
        return imageView
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    private func configureUI() {
        addSubview(backgroundImageView)
        addSubview(titleLabel)
        addSubview(ratingLabel)
        backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: ratingLabel.leadingAnchor, constant: -20),
            
            ratingLabel.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor, constant: -10),
            ratingLabel.widthAnchor.constraint(equalToConstant: 60),
            
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
    
    func setItem(_ item: Movie) {
        titleLabel.text = item.title
        ratingLabel.text = "\(item.rating ?? 0)"
        
        ImageLoader.fetchImage(url: item.background_image ?? "") { [weak self] image in
            DispatchQueue.main.async {
                self?.backgroundImageView.image = image
            }
        }
    }
}
