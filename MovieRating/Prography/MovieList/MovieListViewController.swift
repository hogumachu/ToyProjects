import UIKit
import RxSwift
import RxCocoa

class MovieListViewController: UIViewController {
    struct Dependency {
        let viewModel: MovieListViewModel
    }
    
    // MARK: - Properties
    
    let viewModel: MovieListViewModel
    private let disposeBag = DisposeBag()
    
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
        _ = movieListTableView.rx.setDelegate(self)
        movieListTableView.register(MovieListTableViewCell.self, forCellReuseIdentifier: MovieListTableViewCell.identifier)
        
    }
    
    private func bindViewModel() {
        viewModel.storage.movieList()
            .bind(to: movieListTableView.rx.items(cellIdentifier: MovieListTableViewCell.identifier, cellType: MovieListTableViewCell.self)) { index, item, cell in
                cell.setItem(item)
            }
            .disposed(by: disposeBag)
        
        movieListTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.viewModel.detail(at: indexPath.row)
            })
            .disposed(by: disposeBag)
    }
}

extension MovieListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.frame.height + scrollView.contentOffset.y > scrollView.contentSize.height {
            viewModel.next()
        }
    }
}
