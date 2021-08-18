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
    
    let textView: UITextView = {
        let uiTextView = UITextView()
        return uiTextView
    }()
    
    let textField: UITextField = {
        let uiTextField = UITextField()
        return uiTextField
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
        view.addSubview(textView)
        view.addSubview(textField)
        
        textView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(textField.snp.top).offset(-5)
        }
        
        textField.snp.makeConstraints {
            $0.leading.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalTo(startButton.snp.leading).offset(-5)
            $0.height.equalTo(startButton)
        }
        
        startButton.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    override func subscribe() {
        startButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                viewModel.searchRequest(textField.text!)
                textField.text = ""
            })
            .disposed(by: disposeBag)
        
        viewModel.searchRelay
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] items in
                textView.text = ""
                items.forEach {
                    if let title = $0.title {
                        textView.text += title.htmlRemove
                        textView.text += "\n"
                    }
                    if let address = $0.roadAddress {
                        textView.text += address.htmlRemove
                        textView.text += "\n"
                    }
                    
                    if let telephon = $0.telephon {
                        textView.text += telephon.htmlRemove
                        textView.text += "\n"
                    }
                    textView.text += "\n"
                }
            }).disposed(by: disposeBag)
    }
}
