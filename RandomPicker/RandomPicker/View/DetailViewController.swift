import UIKit
import SnapKit
import RxSwift
import RxDataSources

class DetailViewController: BaseViewController {
    struct Dependency {
        let viewModel: DetailViewModel
    }
    let viewModel: DetailViewModel
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    init(dependency: Dependency) {
        self.viewModel = dependency.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = viewModel.title
        view.backgroundColor = .white
        view.addSubview(tableView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: nil, action: nil)
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.identifier)
        
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func subscribe() {
        viewModel.subContentList
            .bind(to: tableView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: disposeBag)
        
        navigationItem.rightBarButtonItem!.rx.tap
            .subscribe(onNext: { [weak self] in
                // identity 가 title 이므로
                // update 할 때 동일한 이름을 가졌는지 확인하고 데이터 추가해야 함
                // 안그러면 오류남 !
                self?.viewModel.update(subContent: SubContent(title: "더미 데이터", score: 1.0))
            })
            .disposed(by: disposeBag)
    }
}
