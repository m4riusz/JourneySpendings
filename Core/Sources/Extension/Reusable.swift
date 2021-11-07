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

public extension UITableView {
    func register<T: UITableViewCell & Reusable>(_ cell: T.Type) {
        register(cell, forCellReuseIdentifier: cell.reusableIdentifier)
    }

    func dequeueCell<T: UITableViewCell & Reusable>(_ cell: T.Type, indexPath: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: T.reusableIdentifier, for: indexPath) as! T
    }
}

public extension UICollectionView {
    func register<T: UICollectionViewCell & Reusable>(_ cell: T.Type) {
        register(cell, forCellWithReuseIdentifier: cell.reusableIdentifier)
    }

    func dequeueCell<T: UICollectionViewCell & Reusable>(_ cell: T.Type, indexPath: IndexPath) -> T {
        dequeueReusableCell(withReuseIdentifier: T.reusableIdentifier, for: indexPath) as! T
    }
}
