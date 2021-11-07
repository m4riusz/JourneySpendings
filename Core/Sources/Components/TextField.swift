//
//  TextField.swift
//  Core
//
//  Created by Mariusz Sut on 10/10/2021.
//

import UIKit

final public class TextField: UITextField {
    private typealias Colors = Assets.Colors.Core
    private let titleLabel = UILabel()
    private let errorLabel = UILabel()
    private let helperLabel = UILabel()
    private let underlineView = UIView()
    private static let textStyle = FontStyles.body

    public var titleText: String? {
        didSet { update() }
    }

    public var errorText: String? {
        didSet { update() }
    }

    public var helperText: String? {
        didSet { update() }
    }

    public override var placeholder: String? {
        get { attributedPlaceholder?.string }
        set { attributedPlaceholder = newValue?.styled(TextField.textStyle) }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(frame: .zero)
        commonInit()
    }

    private func commonInit() {
        titleLabel.numberOfLines = 1
        errorLabel.numberOfLines = 0
        helperLabel.numberOfLines = 0
        defaultTextAttributes = TextField.textStyle.style.rawAttributes
            .merging([.foregroundColor: Colors.Label.primary], uniquingKeysWith: { $1 })
        addSubview(titleLabel)
        addSubview(underlineView)
        addSubview(errorLabel)
        addSubview(helperLabel)
    }

    private func update() {
        titleLabel.attributedText = titleText?.styled(.subhead, attributes: [.color(Colors.Label.secondary)])
        errorLabel.attributedText = errorText?.styled(.subhead, attributes: [.color(Colors.error)])
        helperLabel.attributedText = helperText?.styled(.footnote)
        underlineView.backgroundColor = errorText.isNilOrEmpty ? Colors.separator : Colors.error
        titleLabel.isHidden = titleText.isNilOrEmpty
        errorLabel.isHidden = errorText.isNilOrEmpty
        helperLabel.isHighlighted = helperText.isNilOrEmpty
        layoutSubviews()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        invalidateIntrinsicContentSize()

        titleLabel.frame = .init(x: 0,
                                 y: 0,
                                 width: frame.width,
                                 height: titleLabelSize.height)
        underlineView.frame = .init(x: 0,
                                    y: titleLabel.frame.maxY + textHeight,
                                    width: frame.width,
                                    height: underlineViewSize.height)
        errorLabel.frame = .init(x: 0,
                                 y: underlineView.frame.maxY,
                                 width: frame.width,
                                 height: erorLabelSize.height)
        helperLabel.frame = .init(x: 0,
                                  y: errorLabel.frame.maxY,
                                  width: frame.width,
                                  height: helperLabelSize.height)
    }

    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        let desiredHeight = bounds.height - titleLabelSize.height - erorLabelSize.height - helperLabelSize.height - underlineViewSize.height
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
        titleLabel.isHidden ? .zero : titleLabel.sizeThatFits(.init(width: frame.width, height: .greatestFiniteMagnitude))
    }

    private var underlineViewSize: CGSize {
        .init(width: frame.width, height: 2)
    }

    private var erorLabelSize: CGSize {
        errorLabel.isHidden ? .zero : errorLabel.sizeThatFits(.init(width: frame.width, height: .greatestFiniteMagnitude))
    }

    private var helperLabelSize: CGSize {
        helperLabel.isHidden ? .zero : helperLabel.sizeThatFits(.init(width: frame.width, height: .greatestFiniteMagnitude))
    }

    private var textHeight: CGFloat {
        TextField.textStyle.style.font.lineHeight
    }
}
