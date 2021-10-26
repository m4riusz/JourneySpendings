//
//  BaseCollectionViewCell.swift
//  Core
//
//  Created by Mariusz Sut on 26/10/2021.
//

import UIKit

open class BaseCollectionViewCell: UICollectionViewCell {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required public init?(coder: NSCoder) {
        super.init(frame: .zero)
        commonInit()
    }

    open func commonInit() {
        /*Nop*/
    }
}
