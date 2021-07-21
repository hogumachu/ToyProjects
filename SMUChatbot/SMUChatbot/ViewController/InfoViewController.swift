//
//  InfoViewController.swift
//  SMUChatbot
//
//  Created by 홍성준 on 2021/07/21.
//

import UIKit

class InfoViewController: UIViewController {
    let collectionList = InfoCollectionViewCellItems.getInfoViewCellItems()
    
    let listCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        layout.sectionInset = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.isPagingEnabled = true
        
        return collectionView
    }()
    
    lazy var pageControl: UIPageControl = {
       let pageControl = UIPageControl()
        pageControl.hidesForSinglePage = true
        pageControl.numberOfPages = collectionList.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .systemBlue
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.addTarget(self, action: #selector(pageSelected(sender:)), for: .valueChanged)
        
        return pageControl
    }()
    
    
    @objc func pageSelected(sender: UIPageControl) {
        let indexPath = IndexPath(item: sender.currentPage, section: 0)
        listCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc func backAction(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func forwardAction(sender: UIButton) {
        let chatVC = ChatViewController()
        chatVC.modalPresentationStyle = .fullScreen
        chatVC.modalTransitionStyle = .flipHorizontal
        self.present(chatVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        listCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        setConstraints()
    }
    
    func setConstraints() {
        view.backgroundColor = .white
        view.initAutoLayout(UIViews: [listCollectionView, pageControl])
        
        NSLayoutConstraint.activate([
            listCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            listCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
    }
    

}

extension InfoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = collectionList[indexPath.row].backgroundColor
        switch collectionList[indexPath.row].index {
        case 0:
            if let button = collectionList[indexPath.row].button {
                button.translatesAutoresizingMaskIntoConstraints = false
                button.addTarget(self, action: #selector(backAction(sender:)), for: .touchUpInside)
                cell.addSubview(button)
                NSLayoutConstraint.activate([
                    button.topAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.topAnchor),
                    button.leadingAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.leadingAnchor, constant: 10)
                ])
            }
        case 2:
            if let button = collectionList[indexPath.row].button {
                button.translatesAutoresizingMaskIntoConstraints = false
                button.addTarget(self, action: #selector(forwardAction(sender: )), for: .touchUpInside)
                cell.addSubview(button)
                NSLayoutConstraint.activate([
                    button.topAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.topAnchor),
                    button.trailingAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.trailingAnchor, constant: -10)
                ])
            }
        default:
            break
        }
        
        return cell
    }
}

extension InfoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}

extension InfoViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.bounds.size.width
        let x = scrollView.contentOffset.x + (width / 2.0)
        let newPage = Int(x / width)
        pageControl.currentPage = newPage
    }
}
