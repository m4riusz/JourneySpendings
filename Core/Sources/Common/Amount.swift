//
//  Amount.swift
//  Core
//
//  Created by Mariusz Sut on 29/09/2021.
//

import Foundation

public struct Amount {
    private struct Constants {
        static let minFractionDigits = 2
        static let maxFractionDigits = 2
        static let groupingSize = 3
    }
    private let value: Double
    private let currency: String

    public init(value: Double, currency: String) {
        self.value = value
        self.currency = currency
    }

    public func formated() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = Constants.minFractionDigits
        numberFormatter.maximumFractionDigits = Constants.maxFractionDigits
        numberFormatter.decimalSeparator = String.Common.comma
        numberFormatter.groupingSeparator = String.Common.space
        numberFormatter.paddingCharacter = String.Common.space
        numberFormatter.groupingSize = Constants.groupingSize
        var formatted = numberFormatter.string(from: NSDecimalNumber(value: value))!
        if !currency.isEmpty {
            formatted.append(contentsOf: " \(currency)")
        }
        return formatted
    }
}
