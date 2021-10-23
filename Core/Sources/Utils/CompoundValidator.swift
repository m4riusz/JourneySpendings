//
//  CompoundValidator.swift
//  Core
//
//  Created by Mariusz Sut on 23/10/2021.
//

import Foundation

public struct CompoundValidator: ValidatorProtocol {
    private let validators: [ValidatorProtocol]

    public init(validators: [ValidatorProtocol]) {
        self.validators = validators
    }

    public func validate(text: String) -> ValidationResult {
        let result = validators.compactMap { $0.validate(text: text) }.first(where: { !$0.isSuccess })
        return result ?? ValidationResult.success
    }
}
