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
    
//    let listCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.isPagingEnabled = true
//        collectionView.backgroundColor = .white
//
//        return collectionView
//    }()
    
    let listCollectionView = ListCollectionView()
    
    // MARK: - Lifecycles
    
    init(dependency: Dependency, payload: ()) {
        self.viewModel = dependency.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func subscribe() {
        collectionObservable.bind(to: listCollectionView.rx.items(cellIdentifier: "InfoCollectionViewCell", cellType: InfoCollectionViewCell.self)) { index, item, cell in
            cell.layer.cornerRadius = cell.frame.height / 2
            cell.backgroundColor = .smu
            cell.summaryLabel.text = item.summary
            cell.detail = item.detailInfo
        }
        .disposed(by: disposeBag)
        
//        listCollectionView.rx.modelSelected(ChatbotInfo.self)
//            .subscribe(onNext: { info in
//                print("\(info.summary), \(info.detailInfo)")
//            })
//            .disposed(by: disposeBag)
//        
//        listCollectionView.rx.itemSelected
//            .subscribe(onNext: { [weak self] indexPath in
//                if indexPath.row == myChatbotInfo.count - 1 {
//                    self?.viewModel.gotoChatVC(self!)
//                }
//            })
//            .disposed(by: disposeBag)
        
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
}


extension InfoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize.zero
        }
        
        let value = (collectionView.frame.width - (flowLayout.sectionInset.left + flowLayout.sectionInset.right + flowLayout.minimumInteritemSpacing)) / 2
        
        return CGSize(width: value, height: value)
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
