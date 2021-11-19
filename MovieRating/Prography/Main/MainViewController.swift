import UIKit

class MainViewController: UIViewController {
    struct Dependency {
        let viewModel: MainViewModel
    }

    // MARK: - Properties
    let viewModel: MainViewModel
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "최소 평점을 입력하세요 (0~9)"
        return label
    }()
    private let scoreTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numberPad
        textField.placeholder = "(0~9)"
        textField.borderStyle = .roundedRect
        return textField
    }()
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.clipsToBounds = true
        button.layer.cornerRadius = 16
        button.layer.cornerCurve = .continuous
        return button
    }()
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.stopAnimating()
        indicator.isHidden = true
        return indicator
    }()
    private lazy var keyboardConstrant: NSLayoutConstraint = {
        return nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindViewModel()
    }
    
    init(dependency: Dependency) {
        self.viewModel = dependency.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeNotification()
    }
    
    // MARK: - Configure
    
    private func configureUI() {
        navigationItem.title = "Movie"
        view.backgroundColor = .white
        
        view.addSubview(scoreLabel)
        view.addSubview(scoreTextField)
        view.addSubview(nextButton)
        view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            scoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            scoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            scoreTextField.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 10),
            scoreTextField.leadingAnchor.constraint(equalTo: scoreLabel.leadingAnchor),
            scoreTextField.trailingAnchor.constraint(equalTo: scoreLabel.trailingAnchor),
            
            nextButton.leadingAnchor.constraint(equalTo: scoreLabel.leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: scoreLabel.trailingAnchor),
            keyboardConstrant,
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.startLoading = { [weak self] in
            self?.loadingIndicator.isHidden = false
            self?.loadingIndicator.startAnimating()
        }
        
        viewModel.endLoading = { [weak self] in
            self?.loadingIndicator.stopAnimating()
            self?.loadingIndicator.isHidden = true
        }
    }
    
    // MARK: - Actions
    
    @objc
    private func nextButtonDidTap() {
        viewModel.next(score: scoreTextField.text)
    }
    
    @objc
    private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            NSLayoutConstraint.deactivate([keyboardConstrant])
            
            keyboardConstrant = nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -keyboardFrame.cgRectValue.height + view.safeAreaInsets.bottom - 20)
            
            UIView.animate(withDuration: 0.3) {
                NSLayoutConstraint.activate([self.keyboardConstrant])
            }
            
            view.layoutIfNeeded()
        }
    }
    
    @objc
    private func keyboardWillHide(_ notification: NotificationCenter) {
        NSLayoutConstraint.deactivate([keyboardConstrant])
        
        keyboardConstrant = nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        
        UIView.animate(withDuration: 0.3) {
            NSLayoutConstraint.activate([self.keyboardConstrant])
        }
        
        view.layoutIfNeeded()
    }
    
    @objc
    private func scoreTextFieldValueChanged(_ notification: Notification) {
        if let tf = notification.object as? UITextField, let text = tf.text {
            if text.count > 1 {
                tf.text = String(text.last!)
            }
        }
    }
    
    // MARK: - Helper
    
    private func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIWindow.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(scoreTextFieldValueChanged), name: UITextField.textDidChangeNotification, object: scoreTextField)
        
    }
    
    private func removeNotification() {
        NotificationCenter.default.removeObserver(self)
    }
}
