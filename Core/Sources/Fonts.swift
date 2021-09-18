//
//  Fonts.swift
//  Core
//
//  Created by Mariusz Sut on 17/09/2021.
//

import UIKit
import CoreGraphics

public enum FontStyles {
    case largeTitle
    case title1
    case title2
    case title3
    case headline
    case body
    case callout
    case subhead
    case footnote
    case capition1
    case capition2

    var style: FontStyle {
        switch self {
        case .largeTitle:
            return .init(font: UIFont(name: FontName.regular.string, size: 34)!, lineHeight: 41, color: .black)
        case .title1:
            return .init(font: UIFont(name: FontName.regular.string, size: 28)!, lineHeight: 34, color: .black)
        case .title2:
            return .init(font: UIFont(name: FontName.regular.string, size: 22)!, lineHeight: 28, color: .black)
        case .title3:
            return .init(font: UIFont(name: FontName.regular.string, size: 20)!, lineHeight: 25, color: .black)
        case .headline:
            return .init(font: UIFont(name: FontName.semibold.string, size: 17)!, lineHeight: 22, color: .black)
        case .body:
            return .init(font: UIFont(name: FontName.regular.string, size: 17)!, lineHeight: 22, color: .black)
        case .callout:
            return .init(font: UIFont(name: FontName.regular.string, size: 16)!, lineHeight: 21, color: .black)
        case .subhead:
            return .init(font: UIFont(name: FontName.regular.string, size: 15)!, lineHeight: 20, color: .black)
        case .footnote:
            return .init(font: UIFont(name: FontName.regular.string, size: 13)!, lineHeight: 18, color: .black)
        case .capition1:
            return .init(font: UIFont(name: FontName.regular.string, size: 12)!, lineHeight: 16, color: .black)
        case .capition2:
            return .init(font: UIFont(name: FontName.regular.string, size: 11)!, lineHeight: 13, color: .black)
        }
    }
}

struct FontStyle {
    let font: UIFont
    let lineHeight: CGFloat
    let color: UIColor
}

enum FontName {
    case bold
    case semibold
    case regular
    case light

    var string: String {
        switch self {
        case .bold: return "OpenSans-Bold"
        case .semibold: return "OpenSans-SemiBold"
        case .regular: return "OpenSans-Regular"
        case .light: return "OpenSans-Light"
        }
    }
}
