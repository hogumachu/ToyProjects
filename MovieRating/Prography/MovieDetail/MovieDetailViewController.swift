import UIKit

class MovieDetailViewController: UIViewController {
    struct Dependency {
        let viewModel: MovieDetailViewModel
    }
    
    // MARK: - Properties
    
    let viewModel: MovieDetailViewModel
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    private let ratingStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        return stack
    }()
    private let ratingTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "평점"
        return label
    }()
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.stopAnimating()
        indicator.isHidden = true
        return indicator
    }()
    
    // MARK: - Lifecycle
    
    init(dependency: Dependency) {
        self.viewModel = dependency.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setItem()
    }
    
    // MARK: - Configure
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(ratingStackView)
        view.addSubview(movieImageView)
        view.addSubview(loadingIndicator)
        
        ratingStackView.addArrangedSubview(ratingTitleLabel)
        ratingStackView.addArrangedSubview(ratingLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            ratingStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            ratingStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            ratingStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            movieImageView.topAnchor.constraint(equalTo: ratingStackView.bottomAnchor, constant: 5),
            movieImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: movieImageView.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: movieImageView.centerYAnchor)
        ])
    }
    
    private func setItem() {
        let item = viewModel.item()
        
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
        
        titleLabel.text = item.title
        ratingLabel.text = "\(item.rating ?? 0)"
        
        ImageLoader.fetchImage(url: item.large_cover_image ?? "") { [weak self] image in
            DispatchQueue.main.async {
                self?.movieImageView.image = image
                self?.loadingIndicator.stopAnimating()
                self?.loadingIndicator.isHidden = true
            }
        }
    }
}
