//
//  UIBarButtonItemExtension.swift
//  Core
//
//  Created by Mariusz Sut on 23/10/2021.
//

import UIKit

extension UIBarButtonItem {
    public convenience init(_ item: SystemItem) {
        self.init(barButtonSystemItem: item, target: nil, action: nil)
    }
}
