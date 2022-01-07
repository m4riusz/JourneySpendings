//
//  Reusable.swift
//  Core
//
//  Created by Mariusz Sut on 26/09/2021.
//

import UIKit

public protocol Reusable {
    static var reusableIdentifier: String { get }
}

public extension Reusable where Self: UIView {
    static var reusableIdentifier: String {
        String(describing: self)
    }
}

public extension UICollectionView {
    func register<T: UICollectionViewCell & Reusable>(_ cell: T.Type) {
        register(cell, forCellWithReuseIdentifier: cell.reusableIdentifier)
    }

    func dequeueCell<T: UICollectionViewCell & Reusable>(_ cell: T.Type, indexPath: IndexPath) -> T {
        dequeueReusableCell(withReuseIdentifier: T.reusableIdentifier, for: indexPath) as! T
    }
    
    func registerHeader<T: UICollectionReusableView & Reusable>(_ cell: T.Type) {
        register(cell, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.reusableIdentifier)
    }

    func dequeueHeader<T: UICollectionReusableView & Reusable>(_ cell: T.Type, indexPath: IndexPath) -> T {
        dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                         withReuseIdentifier: T.reusableIdentifier,
                                         for: indexPath) as! T

    }
    
    convenience init(layout: UICollectionViewLayout) {
        self.init(frame: .zero, collectionViewLayout: layout)
    }
}
