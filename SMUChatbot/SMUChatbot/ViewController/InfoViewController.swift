//
//  InfoViewController.swift
//  SMUChatbot
//
//  Created by 홍성준 on 2021/07/21.
//

import UIKit
import RxSwift
import RxCocoa


class InfoViewController: UIViewController {
    lazy var collectionObservable = Observable.of(myChatbotInfo)
    
    let listCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .white
        
        return collectionView
    }()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
        listCollectionView.register(InfoCollectionViewCell.self, forCellWithReuseIdentifier: "InfoCollectionViewCell")
        
        collectionObservable.bind(to: listCollectionView.rx.items(cellIdentifier: "InfoCollectionViewCell", cellType: InfoCollectionViewCell.self)) { index, item, cell in
            cell.layer.cornerRadius = cell.frame.height / 2
            cell.backgroundColor = .smu
            cell.summaryLabel.text = item.summary
            cell.detail = item.detailInfo
        }
        .disposed(by: disposeBag)
        
        listCollectionView.rx.modelSelected(ChatbotInfo.self)
            .subscribe(onNext: { info in
                print("\(info.summary), \(info.detailInfo)")
            })
            .disposed(by: disposeBag)
        
        listCollectionView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                if indexPath.row == myChatbotInfo.count - 1 {
                    print("다음 페이지로 이동합니다.")
                    let chatVC = ChatViewController()
                    chatVC.modalTransitionStyle = .flipHorizontal
                    chatVC.modalPresentationStyle = .fullScreen
                    self?.present(chatVC, animated: true) { [weak self] in
                        self?.disposeBag = DisposeBag()
                    }
                }
            })
            .disposed(by: disposeBag)
        
        listCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
       
    }
    
    func setConstraints() {
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
}
