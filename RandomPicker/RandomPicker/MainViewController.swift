import UIKit
import RxSwift
import SnapKit

class MainViewController: BaseViewController {
    struct Dependency {
        let viewModel: MainViewModel
    }
    private let viewModel: MainViewModel
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private let addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.clipsToBounds = true
        button.layer.cornerCurve = .continuous
        button.layer.cornerRadius = 40
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
        view.addSubview(tableView)
        view.addSubview(addButton)
        
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        addButton.snp.makeConstraints {
            $0.width.height.equalTo(80)
            $0.trailing.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
    }
    
    override func subscribe() {
        viewModel.contentList
            .bind(to: tableView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: disposeBag)
    }
}

