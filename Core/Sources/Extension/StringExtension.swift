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

    func styled(_ font: FontStyles, attributes: [NSAttributedString.Key: Any] = [:]) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.minimumLineHeight = font.style.lineHeight
        paragraphStyle.maximumLineHeight = font.style.lineHeight

        let finalAttributes: [NSAttributedString.Key: Any] = [
            .font: font.style.font,
            .paragraphStyle: paragraphStyle,
            .foregroundColor: font.style.color
        ].merging(attributes) { $1 }
        return NSAttributedString(string: self, attributes: finalAttributes)
    }
}
