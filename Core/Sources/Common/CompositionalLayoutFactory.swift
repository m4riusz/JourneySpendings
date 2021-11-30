//
//  CompositionalLayoutFactory.swift
//  Core
//
//  Created by Mariusz Sut on 31/10/2021.
//

import UIKit

public protocol CompositionalLayoutFactoryProtocol {
    func tagView(itemSpacing: CGFloat) -> UICollectionViewLayout
    func scrolableTagView(itemSpacing: CGFloat) -> UICollectionViewLayout
    func tableView() -> UICollectionViewLayout
}

public final class CompositionalLayoutFactory: CompositionalLayoutFactoryProtocol {

    public func tagView(itemSpacing: CGFloat) -> UICollectionViewLayout {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .estimated(100),
                                                            heightDimension: .estimated(50)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                         heightDimension: .estimated(50)),
                                                       subitems: [item])
        group.interItemSpacing = .fixed(itemSpacing)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = itemSpacing
        return UICollectionViewCompositionalLayout(section: section)
    }

    public func scrolableTagView(itemSpacing: CGFloat) -> UICollectionViewLayout {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .estimated(100),
                                                            heightDimension: .estimated(50)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .estimated(100),
                                                                         heightDimension: .estimated(50)),
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = itemSpacing
        section.contentInsets = .init(top: 0, leading: itemSpacing, bottom: 0, trailing: itemSpacing)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    public func tableView() -> UICollectionViewLayout {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                       heightDimension: .estimated(50)),
                                                     subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
}
