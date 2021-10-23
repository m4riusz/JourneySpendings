//
//  MaximumLengthValidatorTests.swift
//  Core
//
//  Created by Mariusz Sut on 23/10/2021.
//

import Foundation
import XCTest

@testable import Core

final class MaximumLengthValidatorTests: XCTestCase {
    private var maximumLength: UInt = 2
    private var errorMessage = "Error"
    private var ignoreSpaces = true
    private lazy var sut = MaximumLengthValidator(maximumLength: maximumLength,
                                                  errorMessage: errorMessage,
                                                  ignoreSpaces: ignoreSpaces)

    func testValidationResult() {
        XCTAssertTrue(ValidationResult.success.isSuccess)
        XCTAssertFalse(ValidationResult.failure(message: errorMessage).isSuccess)
    }

    func testValidationFailure() {
        XCTAssertEqual(sut.validate(text: "abc"), .failure(message: errorMessage))
    }

    func testValidationSuccessMaximumValue() {
        XCTAssertEqual(sut.validate(text: "ab"), .success)
    }

    func testValidationSuccess() {
        XCTAssertEqual(sut.validate(text: ""), .success)
    }

    func testValidationSuccessDoNotIgnoreSpaces() {
        ignoreSpaces = false
        XCTAssertEqual(sut.validate(text: "   "), .failure(message: errorMessage))
    }

    func testValidationFailureIgnoreSpaces() {
        XCTAssertEqual(sut.validate(text: "  "), .success)
    }
}
