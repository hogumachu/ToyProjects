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
    private let cardStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
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
        view.addSubview(cardStackView)
        view.addSubview(tableView)
        view.addSubview(addButton)
        
        viewModel.contentList
            .subscribe(onNext: {
                $0[0].items
                    .map { CardView($0.title) }
                    .forEach {
                        self.cardStackView.addArrangedSubview($0)
                    }
            })
            .disposed(by: disposeBag)
        
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        
        cardStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.equalToSuperview().offset(50)
            $0.trailing.equalToSuperview().offset(-50)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(cardStackView.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
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
        tableView.rx.modelSelected(Content.self)
            .subscribe(onNext: { [weak self] content in
                self?.coordinator?.sceneChange(scene: .detailViewController, style: .push, animated: true, content: content)
            }).disposed(by: disposeBag)
    }
}

class CardView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    init(_ title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        backgroundColor = .systemPink
        addSubview(titleLabel)
        clipsToBounds = true
        layer.cornerCurve = .continuous
        layer.cornerRadius = 16
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
