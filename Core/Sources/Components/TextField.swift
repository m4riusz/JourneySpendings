//
//  TextField.swift
//  Core
//
//  Created by Mariusz Sut on 10/10/2021.
//

import UIKit

final public class TextField: UITextField {
    private let titleLabel = UILabel()
    private let errorLabel = UILabel()
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
        errorLabel.numberOfLines = 0
        helperLabel.numberOfLines = 0
        addSubview(titleLabel)
        addSubview(errorLabel)
        addSubview(helperLabel)
    }

    private func update() {
        titleLabel.attributedText = titleText?.styled(.callout)
        errorLabel.attributedText = errorText?.styled(.capition1, attributes: [.color(Assets.Colors.Core.error)])
        helperLabel.attributedText = helperText?.styled(.capition2)
        titleLabel.isHidden = titleText.isNilOrEmpty
        errorLabel.isHidden = errorText.isNilOrEmpty
        helperLabel.isHighlighted = helperText.isNilOrEmpty
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        invalidateIntrinsicContentSize()
        let titleSize = titleLabelSize
        let errorSize = erorLabelSize
        let helperSize = helperLabelSize

        titleLabel.frame = .init(x: 0,
                                 y: 0,
                                 width: titleSize.width,
                                 height: titleSize.height)
        errorLabel.frame = .init(x: 0,
                                 y: titleLabel.frame.maxY + textHeight,
                                 width: errorSize.width,
                                 height: errorSize.height)
        helperLabel.frame = .init(x: 0,
                                  y: errorLabel.frame.maxY,
                                  width: helperSize.width,
                                  height: helperSize.height)
    }

    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        let titleLabelSize = titleLabelSize
        let errorLabelSize = erorLabelSize
        let helperLabelSize = helperLabelSize
        let desiredHeight = bounds.height - titleLabelSize.height - errorLabelSize.height - helperLabelSize.height
        return CGRect(x: 0, y: titleLabelSize.height, width: bounds.width, height: desiredHeight)
    }

    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        textRect(forBounds: bounds)
    }

    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        textRect(forBounds: bounds)
    }

    // MARK: - Private
    private var titleLabelSize: CGSize {
        titleLabel.isHidden ? .zero : titleLabel.sizeThatFits(.init(width: bounds.size.width, height: .greatestFiniteMagnitude))
    }

    private var erorLabelSize: CGSize {
        errorLabel.isHidden ? .zero : errorLabel.sizeThatFits(.init(width: bounds.size.width, height: .greatestFiniteMagnitude))
    }

    private var helperLabelSize: CGSize {
        helperLabel.isHidden ? .zero : helperLabel.sizeThatFits(.init(width: bounds.size.width, height: .greatestFiniteMagnitude))
    }

    private var textHeight: CGFloat {
        FontStyles.body.style.font.lineHeight
    }
}
