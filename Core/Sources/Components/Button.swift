//
//  Button.swift
//  Core
//
//  Created by Mariusz Sut on 19/09/2021.
//

import UIKit

final public class Button: UIButton {
    private typealias Colors = Assets.Colors.Core
    private struct Constants {
        static let edgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        struct Border {
            static let normal: CGFloat = 2
        }
        struct Alpha {
            static let disabled: CGFloat = 0.4
            static let highlited: CGFloat = 0.7
        }
    }

    public enum Style {
        case primary
        case secondary
        case tertiary
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        contentEdgeInsets = Constants.edgeInsets
    }

    public required init?(coder: NSCoder) {
        super.init(frame: .zero)
    }

    convenience init(text: String) {
        self.init(frame: .zero)
        self.text = text
    }

    public var text: String = "" {
        didSet { update() }
    }

    public var style = Style.primary {
        didSet { update() }
    }

    public override var isEnabled: Bool {
        didSet { update() }
    }

    public override var isHighlighted: Bool {
        didSet { update() }
    }

    private func update() {
        setAttributedTitle(text.styled(.subhead, attributes: [.color(normalTextColor)]), for: .normal)
        setAttributedTitle(text.styled(.subhead, attributes: [.color(highlightedTextColor)]), for: .highlighted)
        setAttributedTitle(text.styled(.subhead, attributes: [.color(disabledTextColor)]), for: .disabled)
        backgroundColor = backgroundColorForState
        layer.borderWidth = borderWidthForStyle
        layer.borderColor = borderColorForState.cgColor
    }

    // MARK: - Border width
    private var borderWidthForStyle: CGFloat {
        switch style {
        case .primary: return 0
        case .secondary: return Constants.Border.normal
        case .tertiary: return 0
        }
    }

    // MARK: - Border color
    private var borderColorForState: UIColor {
        switch state {
        case .disabled: return disabledBorderColor
        case .highlighted: return highlightedBorderColor
        default: return normalBorderColor
        }
    }

    private var disabledBorderColor: UIColor {
        switch style {
        case .primary: return .clear
        case .secondary: return Colors.Action.disabled
        case .tertiary: return .clear
        }
    }

    private var highlightedBorderColor: UIColor {
        switch style {
        case .primary: return .clear
        case .secondary: return Colors.Action.primary
        case .tertiary: return .clear
        }
    }

    private var normalBorderColor: UIColor {
        switch style {
        case .primary: return .clear
        case .secondary: return Colors.Action.primary
        case .tertiary: return .clear
        }
    }

    // MARK: - Text color
    private var disabledTextColor: UIColor {
        switch style {
        case .primary: return Colors.Action.primaryText
        case .secondary: return Colors.Action.disabled
        case .tertiary: return Colors.Action.disabled
        }
    }

    private var highlightedTextColor: UIColor {
        switch style {
        case .primary: return Colors.Action.primaryText.withAlphaComponent(Constants.Alpha.highlited)
        case .secondary: return Colors.Action.primaryText
        case .tertiary: return Colors.Action.primary.withAlphaComponent(Constants.Alpha.highlited)
        }
    }

    private var normalTextColor: UIColor {
        switch style {
        case .primary: return Colors.Action.primaryText
        case .secondary: return Colors.Action.primary
        case .tertiary: return Colors.Action.primary
        }
    }

    // MARK: - Background color
    private var backgroundColorForState: UIColor {
        switch state {
        case .disabled: return disabledBackgroundColor
        case .highlighted: return highlightedBackgroundColor
        default: return normalBackgroundColor
        }
    }

    private var disabledBackgroundColor: UIColor {
        switch style {
        case .primary: return Colors.Action.disabled
        case .secondary: return .clear
        case .tertiary: return .clear
        }
    }

    private var highlightedBackgroundColor: UIColor {
        switch style {
        case .primary: return Colors.Action.primary.withAlphaComponent(Constants.Alpha.highlited)
        case .secondary: return Colors.Action.primary
        case .tertiary: return .clear
        }
    }

    private var normalBackgroundColor: UIColor {
        switch style {
        case .primary: return Colors.Action.primary
        case .secondary: return .clear
        case .tertiary: return .clear
        }
    }
}
