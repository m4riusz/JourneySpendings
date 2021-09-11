//
//  UIImageExtension.swift
//  Core
//
//  Created by Mariusz Sut on 11/09/2021.
//

import UIKit

extension UIImage {
    public convenience init?(_ named: String, _ bundle: Bundle) {
        self.init(named: named, in: bundle, compatibleWith: .none)
    }
}
