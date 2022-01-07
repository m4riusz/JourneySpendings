//
//  StringExtension.swift
//  Core
//
//  Created by Mariusz Sut on 14/08/2021.
//

import UIKit

public extension String {
    static func localized(_ table: String, _ key: String, _ bundle: Bundle) -> String {
        NSLocalizedString(key, tableName: table, bundle: bundle, comment: "")
    }

    static func localizedWithArgs(_ table: String, _ key: String, _ bundle: Bundle, _ args: [StringRepresentable]) -> String {
        String(format: NSLocalizedString(key, tableName: table, bundle: bundle, comment: ""), arguments: args.map { $0.string })
    }

    func styled(_ font: FontStyles, attributes: [AttributedStringBuilder.StringAttribute] = []) -> NSAttributedString {
        AttributedStringBuilder(attributes: [
            .font(font.style.font),
            .lineHeight(font.style.lineHeight),
            .color(font.style.color),
            .lineBreakMode(.byTruncatingTail)
        ] + attributes)
            .build(text: self)
    }
}

public extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        self == nil || self!.isEmpty
    }

    var isNilOrBlank: Bool {
        isNilOrEmpty || self!.replacingOccurrences(of: " ", with: "").isEmpty
    }
}

public extension Array where Element == String {
    var joined: String {
        joined(separator: String.Common.commaSeparator)
    }
}

public extension String {
    struct Common {
        public static let space = " "
        public static let comma = ","
        public static let commaSeparator = ", "
    }
}
