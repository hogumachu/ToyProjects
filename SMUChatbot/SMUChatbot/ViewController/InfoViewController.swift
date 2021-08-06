import UIKit
import RxSwift
import RxCocoa

class InfoViewController: BaseViewController {
    struct Dependency {
        let viewModel: InfoViewModel
    }
    
    // MARK: - Properties
    
    let viewModel: InfoViewModel
    lazy var collectionObservable = Observable.of(viewModel.info)
    let listCollectionView = ListCollectionView()
    
    // MARK: - Lifecycles
    
    init(dependency: Dependency, payload: ()) {
        self.viewModel = dependency.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Configures
    
    override func configureUI() {
        listCollectionView.register(InfoCollectionViewCell.self, forCellWithReuseIdentifier: InfoCollectionViewCell.identifier)
        view.initAutoLayout(UIViews: [listCollectionView])
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            listCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            listCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    // MARK: - Subscribes
    
    override func subscribe() {
        collectionObservable.bind(to: listCollectionView.rx.items(cellIdentifier: InfoCollectionViewCell.identifier, cellType: InfoCollectionViewCell.self)) { index, item, cell in
            cell.titleLabel.text = item.title
            cell.detailLabel.text = item.detailInfo
            cell.imageView.backgroundColor = item.color
//            TODO: - 각 Cell에 대해 내용이 확립이 된다면 이에 따른 이미지를 설정해자.
//            cell.imageView.image = item.image
        }
        .disposed(by: disposeBag)

        listCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
}


extension InfoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize.zero
        }
        
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        flowLayout.minimumLineSpacing = 20
        collectionView.collectionViewLayout = flowLayout
        
        let width = collectionView.frame.width - (flowLayout.sectionInset.left + flowLayout.sectionInset.right + flowLayout.minimumInteritemSpacing * 2)
        let height = collectionView.frame.height - (flowLayout.sectionInset.left + flowLayout.sectionInset.right + flowLayout.minimumInteritemSpacing * 2)
        
        return CGSize(width: width, height: height)
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
