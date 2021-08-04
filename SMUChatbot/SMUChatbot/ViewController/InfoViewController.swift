import UIKit
import RxSwift
import RxCocoa

class InfoViewController: BaseViewController {
    
    struct Dependency {
        let viewModel: InfoViewModel
    }
    
    // MARK: - Properties
    // Components - InfoViewControllerComponents
    let viewModel: InfoViewModel
    lazy var collectionObservable = Observable.of(myChatbotInfo)
    let listCollectionView = ListCollectionView()
    var cellRow = 2
    // MARK: - Lifecycles
    
    init(dependency: Dependency, payload: ()) {
        self.viewModel = dependency.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func subscribe() {
        collectionObservable.bind(to: listCollectionView.rx.items(cellIdentifier: InfoCollectionViewCell.identifier, cellType: InfoCollectionViewCell.self)) { index, item, cell in
//            cell.layer.cornerRadius = cell.frame.height / 2
//            cell.layer.cornerRadius = 10
//            cell.layer.borderWidth = 10
//            cell.layer.borderColor = UIColor.smu.cgColor
//            cell.backgroundColor = .white
//            cell.titleLabel.textColor = .black
            cell.titleLabel.text = item.title
            cell.detail = item.detailInfo
        }
        .disposed(by: disposeBag)
        
        listCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Configures
    
    override func configureUI() {
        listCollectionView.register(InfoCollectionViewCell.self, forCellWithReuseIdentifier: "InfoCollectionViewCell")
        view.initAutoLayout(UIViews: [listCollectionView])
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            listCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            listCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        cellRow = (previousTraitCollection?.verticalSizeClass == .compact) ? 2 : 3
    }
}


extension InfoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize.zero
        }
        
        let value = (collectionView.frame.width - (flowLayout.sectionInset.left + flowLayout.sectionInset.right + flowLayout.minimumInteritemSpacing * 2)) / CGFloat(cellRow)
        
        return CGSize(width: value, height: value / 0.6)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case viewModel.info.count - 1:
            coordinator?.chatViewSelected()
        default:
            let info = viewModel.info[indexPath.row]
            coordinator?.infoDetailViewSelected(info: info)
        }
    }
}
