import UIKit
import SnapKit
import RxSwift

class RandomPickView: UIView {
    struct Dependency {
        let viewModel: DetailViewModel
    }
    let viewModel: DetailViewModel
    let disposeBag = DisposeBag()
    lazy var backgroundButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.addTarget(nil, action: #selector(backgroundButtonTap), for: .touchUpInside)
        return button
    }()
    
    init(dependency: Dependency) {
        self.viewModel = dependency.viewModel
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(RandomTableViewCell.self , forCellReuseIdentifier: RandomTableViewCell.identifier)
        viewModel.subContentList
            .bind(to: tableView.rx.items(dataSource: viewModel.randomTableViewDataSource))
            .disposed(by: disposeBag)
        
        backgroundColor = .init(white: 0, alpha: 0.2)
        
        addSubview(backgroundButton)
        addSubview(tableView)
        
        backgroundButton.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(200)
            $0.leading.equalToSuperview().offset(50)
            $0.trailing.equalToSuperview().offset(-50)
            $0.bottom.equalToSuperview().offset(-200)
        }
        
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func backgroundButtonTap() {
        isHidden = !isHidden
    }
}
