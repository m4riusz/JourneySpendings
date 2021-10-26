//
//  BaseTableViewCell.swift
//  Core
//
//  Created by Mariusz Sut on 26/09/2021.
//

import UIKit

open class BaseTableViewCell: UITableViewCell {

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: Self.reusableIdentifier)
        commonInit()
    }

    public required init?(coder: NSCoder) {
        super.init(style: .default, reuseIdentifier: Self.reusableIdentifier)
        commonInit()
    }

    open func commonInit() {
        /*Nop*/
    }
}
