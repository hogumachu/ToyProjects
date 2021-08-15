import UIKit
import RxSwift

class MainViewController: BaseViewController {
    struct Dependency {
        let viewModel: MainViewModel
    }
    
    // MARK: - Properties
    
    let viewModel: MainViewModel
    let smuLabel = HeavyTitleLabel()
    let capstoneLabel = HeavyTitleLabel()
    let teamNameLabel = HeavyTitleLabel()
    
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
        
        nextViewController()
    }
    
    // MARK: - Configures
    
    override func configureUI() {
        smuLabel.text = "상명대학교"
        smuLabel.textColor = .smu
        capstoneLabel.text = "캡스톤디자인"
        capstoneLabel.textColor = .smu
        teamNameLabel.text = "채팅해조"
        teamNameLabel.textColor = .smu
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
    
    // MARK: - Subscribe
    
    func nextViewController() {
        Observable.concat([
            viewModel.appear(smuLabel, duration: 1),
            viewModel.appear(capstoneLabel, duration: 1),
            viewModel.appear(teamNameLabel, duration: 1),
            gotoInfoView()
        ]).subscribe()
        .disposed(by: disposeBag)
    }
    
    func gotoInfoView() -> Observable<Void> {
        return Observable<Void>.create { [unowned self] observer in
            observer.onNext(())
            coordinator?.gotoInfoViewController()
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
}
