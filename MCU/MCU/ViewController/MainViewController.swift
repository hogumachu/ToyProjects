import UIKit

class MainViewController: BaseViewController, UIScrollViewDelegate {
    
    struct Dependency {
        let viewModel: MainViewModel
    }
    let viewModel: MainViewModel
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.isHidden = true
        return indicator
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    let releaseLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 0
        return label
    }()
    let posterView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    let nextButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
        button.configuration = .filled()
        return button
    }()
    
    init(dependency: Dependency) {
        self.viewModel = dependency.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        view.addSubviewsAndAutoresizingFalse(scrollView)
        scrollView.addSubviewsAndAutoresizingFalse(loadingIndicator, titleLabel, releaseLabel, posterView, overviewLabel, nextButton)
        
        scrollView.widthAnchor.constraint(equalToConstant: view.bounds.size.width).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        releaseLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        releaseLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2).isActive = true
        
        posterView.topAnchor.constraint(equalTo: releaseLabel.bottomAnchor, constant: 5).isActive = true
        posterView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        posterView.widthAnchor.constraint(equalToConstant: view.bounds.size.width - 20).isActive = true
        posterView.heightAnchor.constraint(lessThanOrEqualTo: posterView.widthAnchor, multiplier: 1.5).isActive = true
        
        overviewLabel.topAnchor.constraint(equalTo: posterView.bottomAnchor, constant: 10).isActive = true
        overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        nextButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 10).isActive = true
        nextButton.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 10).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10).isActive = true
    }
    
    override func subscribe() {
        viewModel.loadingStart = { [weak self] in
            DispatchQueue.main.async {
                self?.loadingIndicator.isHidden = false
                self?.loadingIndicator.startAnimating()
            }
            
        }
        
        viewModel.loadingEnd = { [weak self] in
            DispatchQueue.main.async {
                self?.loadingIndicator.stopAnimating()
                self?.loadingIndicator.isHidden = true
            }
        }
        
        viewModel.dataUpdated = { [weak self] in
            guard let mcu = self?.viewModel.getData() else { return }
            self?.updateData(mcu)
        }
        
        viewModel.fetchOrigin()
    }
    
    private func updateData(_ mcu: Mcu) {
        DispatchQueue.main.async { [weak self] in
            self?.titleLabel.text = "\(mcu.title) (\(mcu.type))"
            self?.releaseLabel.text = "\(mcu.releaseDate) (\(mcu.daysUntil)일 후 개봉)"
            self?.overviewLabel.text = mcu.overview
        }
        
        ImageLoader.loadImage(url: mcu.posterUrl) { [weak self] image in
            self?.posterView.image = image
        }
        
        guard let title = mcu.followingProduction.title else {
            DispatchQueue.main.async { [weak self] in
                self?.nextButton.isHidden = true
            }
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.nextButton.setTitle("\(title)", for: .normal)
            self?.nextButton.isHidden = false
        }
    }
    
    @objc func nextButtonAction() {
        viewModel.fetchNext(viewModel.getData().releaseDate)
        scrollView.setContentOffset(CGPoint.zero, animated: true)
    }
}

