//
//  MovieView.swift
//  ITunesMovies
//
//  Created by Андрей Соколов on 01.03.2024.
//

import UIKit

class MovieView: UIView {
    
    @UseAutolayout var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: createLayout())
        addSubview(collectionView)
        backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(Constants.layout.itemSizeWidth),
                                              heightDimension: .fractionalHeight(Constants.layout.itemSizeHeight))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = Constants.layout.itemContentInsets
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(Constants.layout.groupSizeWidth),
                                               heightDimension: .fractionalWidth(Constants.layout.groupSizeHeight))
    
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       repeatingSubitem: item,
                                                       count: Constants.layout.groupItemsCount)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = Constants.layout.sectionContentInsets
        section.interGroupSpacing = Constants.layout.interGoupSpacing
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}
