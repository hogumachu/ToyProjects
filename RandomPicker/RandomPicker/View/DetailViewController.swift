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
    private let randomButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemPink
        button.clipsToBounds = true
        button.layer.cornerCurve = .continuous
        button.layer.cornerRadius = 40
        return button
    }()
    private let addView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.backgroundColor = .orange
        view.layer.cornerRadius = 16
        view.layer.cornerCurve = .continuous
        return view
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "제목"
        return label
    }()
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .line
        return textField
    }()
    private let titleStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        return stack
    }()
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "점수"
        return label
    }()
    private let scoreTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .line
        textField.keyboardType = .numberPad
        return textField
    }()
    private let scoreStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        return stack
    }()
    private let addCancelStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        return stack
    }()
    private let addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("추가", for: .normal)
        button.setTitle("X", for: .disabled)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("취소", for: .normal)
        button.titleLabel?.textAlignment = .center
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
        view.addSubview(addView)
        addView.addSubview(titleStackView)
        addView.addSubview(scoreStackView)
        addView.addSubview(addCancelStackView)
        
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(titleTextField)
        scoreStackView.addArrangedSubview(scoreLabel)
        scoreStackView.addArrangedSubview(scoreTextField)
        
        addCancelStackView.addArrangedSubview(cancelButton)
        addCancelStackView.addArrangedSubview(addButton)
        
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.identifier)
        
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        randomButton.snp.makeConstraints {
            $0.width.height.equalTo(80)
            $0.trailing.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        addView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(50)
            $0.trailing.equalToSuperview().offset(-50)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        titleStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
        }
        titleLabel.snp.makeConstraints {
            $0.width.equalTo(40)
        }
        titleTextField.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing)
        }
        
        scoreStackView.snp.makeConstraints {
            $0.top.equalTo(titleStackView.snp.bottom).offset(4)
            $0.leading.trailing.equalTo(titleStackView)
        }
        
        scoreLabel.snp.makeConstraints {
            $0.width.equalTo(40)
        }
        scoreTextField.snp.makeConstraints {
            $0.leading.equalTo(scoreLabel.snp.trailing)
        }
        
        addCancelStackView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-5)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
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
                self?.addView.isHidden = false
            })
            .disposed(by: disposeBag)
        
        randomButton.rx.tap
            .subscribe(onNext: { [weak viewModel] in
                print(viewModel?.random().title ?? "")
            })
            .disposed(by: disposeBag)
        
        Observable.zip(titleTextField.rx.text, scoreTextField.rx.text)
            .subscribe(onNext: { [weak self] title, score in
                guard let title = title, let score = score else { return }
                
                if title.isEmpty || score.isEmpty {
                    self?.addButton.isEnabled = false
                } else {
                    self?.addButton.isEnabled = true
                }
            })
            .disposed(by: disposeBag)
        
        addButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let title = self?.titleTextField.text else { return }
                guard let score = self?.scoreTextField.text else { return }
                guard let valid = self?.viewModel.validTitle(title) else { return }
                
                if valid {
                    self?.viewModel.update(subContent: SubContent(title: title, score: Double(score) ?? 0.0))
                    self?.addView.isHidden = true
                } else {
                    self?.titleTextField.text = ""
                    self?.addButton.isEnabled = false
                }
            })
            .disposed(by: disposeBag)
    }
}

