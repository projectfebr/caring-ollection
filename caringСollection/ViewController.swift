//
//  ViewController.swift
//  caringСollection
//
//  Created by Aleksandr Bolotov on 26.07.2023.
//

import UIKit

class ViewController: UIViewController {
    private let itemWidth: CGFloat = 300
    private let itemSpacing: CGFloat = 20
    
    private lazy var collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.itemSize = CGSize(width: itemWidth, height: 400)
        viewLayout.scrollDirection = .horizontal
        viewLayout.minimumLineSpacing = itemSpacing
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "myCell")
    }
    
    private func setupLayouts() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        // Layout constraints for `collectionView`
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath)
        cell.backgroundColor = .systemGray
        cell.layer.cornerRadius = 8
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let ratio = (targetContentOffset.pointee.x / CGFloat(itemWidth + itemSpacing))
        let i = Int(ratio.rounded(velocity.x > 0 ? .up : .down))
        let point = CGPoint (x: CGFloat((itemWidth + itemSpacing) * CGFloat(i)), y: targetContentOffset.pointee.y)
        targetContentOffset.pointee = point
    }
}
