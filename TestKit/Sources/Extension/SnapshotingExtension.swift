//
//  SnapshotingExtension.swift
//  Core
//
//  Created by Mariusz Sut on 22/09/2021.
//

import UIKit
import SnapshotTesting

public extension Snapshotting where Value == UIView, Format == UIImage {
    static var standardPrecissionImage: Snapshotting {
        .image(precision: 0.95)
    }
}
