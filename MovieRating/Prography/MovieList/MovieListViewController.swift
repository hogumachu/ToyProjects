import UIKit

class MovieListViewController: UIViewController {
    struct Dependency {
        let viewModel: MovieListViewModel
    }
    
    // MARK: - Properties
    
    let viewModel: MovieListViewModel
    
    private let movieListTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.stopAnimating()
        indicator.isHidden = true
        indicator.color = .systemBlue
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
        configureTableView()
        bindViewModel()
    }
    
    // MARK: - Configure
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationItem.titleView = loadingIndicator
        
        view.addSubview(movieListTableView)
        
        NSLayoutConstraint.activate([
            movieListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureTableView() {
        movieListTableView.delegate = self
        movieListTableView.dataSource = self
        movieListTableView.register(MovieListTableViewCell.self, forCellReuseIdentifier: MovieListTableViewCell.identifier)
    }
    
    private func bindViewModel() {
        viewModel.startLoading = { [weak self] in
            self?.loadingIndicator.isHidden = false
            self?.loadingIndicator.startAnimating()
        }
        
        viewModel.endLoading = { [weak self] in
            self?.loadingIndicator.stopAnimating()
            self?.loadingIndicator.isHidden = true
            
            self?.movieListTableView.reloadData()
        }
    }
}

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.movie(at: indexPath.row)
        viewModel.detail(movie: movie)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension MovieListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.identifier, for: indexPath) as! MovieListTableViewCell
        let movie = viewModel.movie(at: indexPath.row)
        
        cell.setItem(movie)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieCount()
    }
}

extension MovieListViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.frame.height + scrollView.contentOffset.y > scrollView.contentSize.height {
            viewModel.next()
        }
    }
}
