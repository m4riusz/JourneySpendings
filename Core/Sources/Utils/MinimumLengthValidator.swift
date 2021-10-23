//
//  MinimumLengthValidator.swift
//  Core
//
//  Created by Mariusz Sut on 23/10/2021.
//

import Foundation

public struct MinimumLengthValidator: ValidatorProtocol {
    private let minimumLength: UInt
    private let errorMessage: String
    private let ignoreSpaces: Bool

    public init(minimumLength: UInt, errorMessage: String, ignoreSpaces: Bool = true) {
        self.minimumLength = minimumLength
        self.errorMessage = errorMessage
        self.ignoreSpaces = ignoreSpaces
    }

    public func validate(text: String) -> ValidationResult {
        let final = ignoreSpaces ? text.replacingOccurrences(of: String.Common.space, with: "") : text
        return final.count >= minimumLength ? .success : .failure(message: errorMessage)
    }
}
