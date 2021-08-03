import UIKit

class MainViewController: BaseViewController {
    
    
    struct Dependency {
        let viewModel: MainViewModel
    }
    
    // MARK: - Properties
    let viewModel: MainViewModel
    
    let smuLabel: UILabel = {
        let label = UILabel()
        label.text = "상명대학교"
        label.textColor = .smu
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 70, weight: .heavy)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let capstoneLabel: UILabel = {
        let label = UILabel()
        label.text = "캡스톤디자인"
        label.textColor = .smu
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 70, weight: .heavy)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let teamNameLabel: UILabel = {
        let label = UILabel()
        label.text = "채팅해조"
        label.textColor = .smu
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 70, weight: .heavy)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    // MARK: - Lifecycles
    
    init(dependency: Dependency, payload: ()) {
        viewModel = dependency.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.coordinator?.startMainViewContoller()
//        self.viewModel.gotoInfoVCAfterAnimate([smuLabel, capstoneLabel, teamNameLabel], self)
    }
    
    
    // MARK: - Configures
    
    override func configureUI() {
        view.backgroundColor = .smu
        view.initAutoLayout(UIViews: [smuLabel, capstoneLabel, teamNameLabel])
        NSLayoutConstraint.activate([
            smuLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            smuLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            smuLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            capstoneLabel.topAnchor.constraint(equalTo: smuLabel.bottomAnchor, constant: 5),
            capstoneLabel.leadingAnchor.constraint(equalTo: smuLabel.leadingAnchor),
            capstoneLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            teamNameLabel.topAnchor.constraint(equalTo: capstoneLabel.bottomAnchor, constant: 5),
            teamNameLabel.leadingAnchor.constraint(equalTo: capstoneLabel.leadingAnchor),
            teamNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
        ])
    }
}
