import UIKit
import RxSwift
import RxCocoa

class SearchViewController: BaseViewController {
    struct Dependency {
        let viewModel: SearchViewModel
    }
    
    // MARK: - Properties
    let viewModel: SearchViewModel
    var searchText: String?
    lazy var titleLabel: UILabel = {
        let uiLabel = UILabel()
        uiLabel.textColor = .systemGreen
        uiLabel.font = .systemFont(ofSize: 30, weight: .heavy)
        uiLabel.numberOfLines = 0
        return uiLabel
    }()
    let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .systemGreen
        return indicator
    }()
    let tableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    // MARK: - Lifecycles
    
    init(dependency: Dependency, payload: ()) {
        viewModel = dependency.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let text = searchText {
            titleLabel.text = text
            viewModel.searchRequest(text)
        }
    }
    
    // MARK: - Configures
    
    override func configureUI() {
        view.backgroundColor = .white
        view.addSubviews(titleLabel, loadingIndicator, tableView)
        
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.height.equalTo(50)
        }
        
        loadingIndicator.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(5)
            $0.top.equalTo(titleLabel)
            $0.height.width.equalTo(titleLabel.snp.height)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Subscribe
    
    override func subscribe() {
        viewModel.searchRelay
            .bind(to: tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) { index, item, cell in
                cell.titleLabel.text = item.title?.htmlRemove
                cell.address.text = item.address
                cell.telephon.text = item.telephon
            }.disposed(by: disposeBag)
        
        viewModel.loadingRelay
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] order in
                if order {
                    loadingIndicator.isHidden = false
                    loadingIndicator.startAnimating()
                } else {
                    loadingIndicator.stopAnimating()
                    loadingIndicator.isHidden = true
                }
            })
            .disposed(by: disposeBag)
    }
}
