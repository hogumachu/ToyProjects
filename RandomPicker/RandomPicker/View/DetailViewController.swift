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
            .subscribe(onNext: { [weak self] in
                // identity 가 title 이므로
                // update 할 때 동일한 이름을 가졌는지 확인하고 데이터 추가해야 함
                // 안그러면 오류남 !
//                self?.viewModel.update(subContent: SubContent(title: "더미 데이터", score: 1.0))
//                self?.addView.isHidden = false
                self?.addContentView.changeHidden()
            })
            .disposed(by: disposeBag)
        
        randomButton.rx.tap
            .subscribe(onNext: { [weak viewModel] in
                print(viewModel?.random().title ?? "")
            })
            .disposed(by: disposeBag)
        
//        Observable.zip(titleTextField.rx.text, scoreTextField.rx.text)
//            .subscribe(onNext: { [weak self] title, score in
//                guard let title = title, let score = score else { return }
//
//                if title.isEmpty || score.isEmpty {
//                    self?.addButton.isEnabled = false
//                } else {
//                    self?.addButton.isEnabled = true
//                }
//            })
//            .disposed(by: disposeBag)
//
//        addButton.rx.tap
//            .subscribe(onNext: { [weak self] in
//                guard let title = self?.titleTextField.text else { return }
//                guard let score = self?.scoreTextField.text else { return }
//                guard let valid = self?.viewModel.validTitle(title) else { return }
//
//                if valid {
//                    self?.viewModel.update(subContent: SubContent(title: title, score: Double(score) ?? 0.0))
//                    self?.addView.isHidden = true
//                } else {
//                    self?.titleTextField.text = ""
//                    self?.addButton.isEnabled = false
//                }
//            })
//            .disposed(by: disposeBag)
    }
}

