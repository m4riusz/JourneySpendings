//
//  UIEdgeInsetsExtension.swift
//  Core
//
//  Created by Mariusz Sut on 22/09/2021.
//

import UIKit

extension UIEdgeInsets {
    init(all value: CGFloat) {
        self.init(top: value, left: value, bottom: value, right: value)
    }
}
