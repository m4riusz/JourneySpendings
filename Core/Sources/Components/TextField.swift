//
//  TextField.swift
//  Core
//
//  Created by Mariusz Sut on 10/10/2021.
//

import UIKit

final public class TextField: UITextField {
    private let titleLabel = UILabel()
    private let errorLabal = UILabel()
    private let helperLabel = UILabel()

    public var titleText: String? {
        didSet { update() }
    }

    public var errorText: String? {
        didSet { update() }
    }

    public var helperText: String? {
        didSet { update() }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(frame: .zero)
    }

    private func commonInit() {
        titleLabel.numberOfLines = 1
        addSubview(titleLabel)
        addSubview(errorLabal)
        addSubview(helperLabel)
    }

    private func update() {

    }
}
