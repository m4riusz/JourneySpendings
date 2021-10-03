//
//  AttributedStringBuilder.swift
//  Core
//
//  Created by Mariusz Sut on 03/10/2021.
//

import UIKit

public class AttributedStringBuilder {
    private let attributes: [StringAttribute]

    public enum StringAttribute {
        case font(_ font: UIFont)
        case color(_ color: UIColor)
        case lineHeight(_ lineHeight: CGFloat)
        case alignment(_ alignment: NSTextAlignment)
    }

    public init(attributes: [StringAttribute]) {
        self.attributes = attributes
    }

    private var rawAttributes: [NSAttributedString.Key: Any] {
        var currentAttributes: [NSAttributedString.Key: Any] = [:]
        attributes.forEach { applyAttribute(currentAttributes: &currentAttributes, attribute: $0) }
        return currentAttributes
    }

    private func applyAttribute(currentAttributes: inout [NSAttributedString.Key: Any], attribute: StringAttribute) {
        switch attribute {
        case .font(let font):
            currentAttributes[.font] = font
        case .color(let color):
            currentAttributes[.foregroundColor] = color
        case .lineHeight(let lineHeight):
            let paragraph = paragraphFrom(currentAttributes: &currentAttributes)
            paragraph.minimumLineHeight = lineHeight
            paragraph.maximumLineHeight = lineHeight
        case .alignment(let alignment):
            let paragraph = paragraphFrom(currentAttributes: &currentAttributes)
            paragraph.alignment = alignment
        }
    }

    private func paragraphFrom(currentAttributes: inout [NSAttributedString.Key: Any]) -> NSMutableParagraphStyle {
        guard let paragraphStyle = currentAttributes[.paragraphStyle] as? NSMutableParagraphStyle  else {
            let paragraph = NSMutableParagraphStyle()
            currentAttributes[.paragraphStyle] = paragraph
            return paragraph
        }
        return paragraphStyle
    }

    public func build(text: String) -> NSAttributedString {
        NSAttributedString(string: text, attributes: rawAttributes)
    }
}
