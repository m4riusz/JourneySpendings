//
//  UniqueStringValidator.swift
//  Core
//
//  Created by Mariusz Sut on 06/11/2021.
//

import Foundation

public struct UniqueStringValidator: ValidatorProtocol {
    private let strings: [String]
    private let errorMessage: String

    public init(strings: [String], errorMessage: String) {
        self.strings = strings
        self.errorMessage = errorMessage
    }

    public func validate(text: String) -> ValidationResult {
        !strings.contains(text) ? .success : .failure(message: errorMessage)
    }
}
