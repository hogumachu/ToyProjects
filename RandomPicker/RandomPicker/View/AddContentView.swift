import UIKit
import SnapKit
import RxSwift

class AddContentView: UIView {
    // MARK: - Properties
    lazy var addButtonEvent = addButton.rx.tap
    private lazy var cancelBackgroundButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(nil, action: #selector(changeHidden), for: .touchUpInside)
        return button
    }()
    private let addView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.cornerCurve = .continuous
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
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
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("취소", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.addTarget(nil, action: #selector(changeHidden), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    // MARK: - Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 0, alpha: 0.2)
        addSubview(cancelBackgroundButton)
        addSubview(addView)
        addView.addSubview(titleStackView)
        addView.addSubview(scoreStackView)
        addView.addSubview(addCancelStackView)
        
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(titleTextField)
        scoreStackView.addArrangedSubview(scoreLabel)
        scoreStackView.addArrangedSubview(scoreTextField)
        
        addCancelStackView.addArrangedSubview(cancelButton)
        addCancelStackView.addArrangedSubview(addButton)
        
        cancelBackgroundButton.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    @objc
    func changeHidden() {
        isHidden = !isHidden
        
        if isHidden {
            titleTextField.text = ""
            scoreTextField.text = ""
            resignFirstResponder()
        }
    }
    
    func pushTextFieldTexts() -> (title: String?, score: String?) {
        return (titleTextField.text, scoreTextField.text)
    }
}
