import UIKit
import SnapKit
import RxSwift
import RxDataSources

class DetailViewController: BaseViewController {
    struct Dependency {
        let viewModel: DetailViewModel
    }
    let viewModel: DetailViewModel
    
    private let addContentView: AddContentView = {
        let addContentView = AddContentView()
        addContentView.translatesAutoresizingMaskIntoConstraints = false
        addContentView.isHidden = true
        return addContentView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private let randomButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemPink
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
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: nil, action: nil)
        
        title = viewModel.title
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(randomButton)
        view.addSubview(addContentView)
        
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.identifier)
        
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        randomButton.snp.makeConstraints {
            $0.width.height.equalTo(80)
            $0.trailing.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        addContentView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func subscribe() {
        viewModel.subContentList
            .bind(to: tableView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: disposeBag)
        
        navigationItem.rightBarButtonItem!.rx.tap
            .subscribe(onNext: { [unowned self] in
                addContentView.changeHidden()
            })
            .disposed(by: disposeBag)
        
        // TODO: - Random Select
        randomButton.rx.tap
            .subscribe(onNext: { [unowned viewModel] in
                print(viewModel.random().title)
            })
            .disposed(by: disposeBag)
        
        addContentView.addButtonEvent
            .subscribe(onNext: { [unowned self] in
                _ = viewModel
                    .checkAndUpdateContent(addContentView.pushTextFieldTexts())
                addContentView.changeHidden()
            })
            .disposed(by: disposeBag)
    }
}

