//
//  CompoundValidatorTests.swift
//  Core
//
//  Created by Mariusz Sut on 23/10/2021.
//

import Foundation
import XCTest

@testable import Core

final class CompoundValidatorTests: XCTestCase {
    private var minimumLength: UInt = 1
    private var maximumLength: UInt = 3
    private var errorMessageMaximum = "Too long"
    private var errorMessageMinimum = "Too short"

    private lazy var maximumLengthValidator = MaximumLengthValidator(maximumLength: maximumLength,
                                                                    errorMessage: errorMessageMaximum)
    private lazy var minimumLengthValidator = MinimumLengthValidator(minimumLength: minimumLength,
                                                                     errorMessage: errorMessageMinimum)
    private lazy var sut = CompoundValidator(validators: [minimumLengthValidator, maximumLengthValidator])

    func testSuccessValidation() {
        XCTAssertEqual(sut.validate(text: "ok"), .success)
    }

    func testFailureValidationTooShort() {
        XCTAssertEqual(sut.validate(text: ""), .failure(message: errorMessageMinimum))
    }

    func testFailureValidationTooLong() {
        XCTAssertEqual(sut.validate(text: "abcd"), .failure(message: errorMessageMaximum))
    }
}
