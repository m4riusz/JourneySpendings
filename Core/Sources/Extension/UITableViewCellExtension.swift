//
//  UITableViewCellExtension.swift
//  Core
//
//  Created by Mariusz Sut on 26/09/2021.
//

import UIKit

public extension UITableViewCell {
    class var reusableIdentifier: String {
        String(describing: self)
    }
}
