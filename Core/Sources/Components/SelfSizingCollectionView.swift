//
//  SelfSizingCollectionView.swift
//  Core
//
//  Created by Mariusz Sut on 30/10/2021.
//

import UIKit

final class SelfSizingCollectionView: UICollectionView {

    convenience init(collectionViewLayout layout: UICollectionViewLayout) {
        self.init(frame: .zero, collectionViewLayout: layout)
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        if !bounds.size.equalTo(intrinsicContentSize) {
            invalidateIntrinsicContentSize()
        }
    }

    override public var intrinsicContentSize: CGSize {
        contentSize
    }
}
