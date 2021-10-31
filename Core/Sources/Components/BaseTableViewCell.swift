//
//  BaseTableViewCell.swift
//  Core
//
//  Created by Mariusz Sut on 26/09/2021.
//

import UIKit

open class BaseTableViewCell: UITableViewCell {

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    public required init?(coder: NSCoder) {
        fatalError("Coder not supported")
    }

    open func commonInit() {
        /*Nop*/
    }
}
