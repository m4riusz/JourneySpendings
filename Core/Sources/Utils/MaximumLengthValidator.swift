//
//  MaximumLengthValidator.swift
//  Core
//
//  Created by Mariusz Sut on 23/10/2021.
//

import Foundation

public struct MaximumLengthValidator: ValidatorProtocol {
    private let maximumLength: UInt
    private let errorMessage: String
    private let ignoreSpaces: Bool

    public init(maximumLength: UInt, errorMessage: String, ignoreSpaces: Bool = true) {
        self.maximumLength = maximumLength
        self.errorMessage = errorMessage
        self.ignoreSpaces = ignoreSpaces
    }

    public func validate(text: String) -> ValidationResult {
        let final = ignoreSpaces ? text.replacingOccurrences(of: String.Common.space, with: "") : text
        return final.count <= maximumLength ? .success : .failure(message: errorMessage)
    }
}
