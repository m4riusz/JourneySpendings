//
//  UITableViewExtension.swift
//  Core
//
//  Created by Mariusz Sut on 26/09/2021.
//

import UIKit
import RxDataSources
import RxSwift

public extension UITableView {
    func register(_ cell: UITableViewCell.Type) {
        register(cell, forCellReuseIdentifier: cell.reusableIdentifier)
    }

    func dequeueCell<T: UITableViewCell>(_ cell: T.Type, indexPath: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: T.reusableIdentifier, for: indexPath) as! T
    }
}
