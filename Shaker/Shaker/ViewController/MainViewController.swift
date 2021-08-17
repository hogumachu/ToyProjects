import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MainViewController: BaseViewController {
    struct Dependency {
        let viewModel: MainViewModel
    }
    
    // MARK: - Properties
    
    let viewModel: MainViewModel
    
    let startButton: UIButton = {
        let uiButton = UIButton()
        uiButton.setTitle(" Start ", for: .normal)
        uiButton.setTitleColor(.white, for: .normal)
        uiButton.backgroundColor = .systemPink
        uiButton.layer.masksToBounds = true
        uiButton.layer.cornerRadius = 8
        
        return uiButton
    }()
    
    
    // MARK: - Lifecycles
    
    init(dependency: Dependency, payload: ()) {
        viewModel = dependency.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Configures
    
    override func configureUI() {
        title = "MainViewController"
        view.backgroundColor = .purple
        
        view.addSubview(startButton)
        
        startButton.snp.makeConstraints {
            $0.centerX.centerY.equalTo(view)
        }
    }
    
    override func subscribe() {
        startButton.rx.tap
            .subscribe(onNext: { _ in
                print("Tapped")
            })
            .disposed(by: disposeBag)
    }
}
