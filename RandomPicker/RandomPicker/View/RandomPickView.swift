import UIKit
import SnapKit
import RxSwift

class RandomPickView: UIView {
    struct Dependency {
        let viewModel: DetailViewModel
    }
    let viewModel: DetailViewModel
    let disposeBag = DisposeBag()
    
    init(dependency: Dependency) {
        self.viewModel = dependency.viewModel
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(RandomCollectionViewCell.self, forCellWithReuseIdentifier: RandomCollectionViewCell.identifier)
        viewModel.subContentList
            .bind(to: collectionView.rx.items(dataSource: viewModel.collectionViewDataSource))
            .disposed(by: disposeBag)
        
        backgroundColor = .init(white: 0, alpha: 0.2)
        
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(200)
            $0.leading.equalToSuperview().offset(50)
            $0.trailing.equalToSuperview().offset(-50)
            $0.bottom.equalToSuperview().offset(-200)
        }
        
        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = false
        collectionView.clipsToBounds = true
        collectionView.layer.cornerRadius = 8
        collectionView.layer.cornerCurve = .continuous
        
        return collectionView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RandomPickView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowlayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return .zero
        }
        
        flowlayout.sectionInset = UIEdgeInsets(top: 40, left: 10, bottom: 40, right: 10)
        flowlayout.minimumLineSpacing = 20
        collectionView.collectionViewLayout = flowlayout
        
        let width = collectionView.frame.width - (flowlayout.sectionInset.left + flowlayout.sectionInset.right + flowlayout.minimumLineSpacing * 2)
        let height = collectionView.frame.height - (flowlayout.sectionInset.left + flowlayout.sectionInset.right + flowlayout.minimumLineSpacing * 2)
        
        return CGSize(width: width, height: height)
    }
}
