//
//  MinimumLengthValidatorTests.swift
//  Core
//
//  Created by Mariusz Sut on 23/10/2021.
//

import Foundation
import XCTest

@testable import Core

final class MinimumLengthValidatorTests: XCTestCase {
    private var minimumLength: UInt = 1
    private var errorMessage = "Error"
    private var ignoreSpaces = true
    private lazy var sut = MinimumLengthValidator(minimumLength: minimumLength,
                                                  errorMessage: errorMessage,
                                                  ignoreSpaces: ignoreSpaces)

    func testValidationResult() {
        XCTAssertTrue(ValidationResult.success.isSuccess)
        XCTAssertFalse(ValidationResult.failure(message: errorMessage).isSuccess)
    }

    func testValidationSuccess() {
        XCTAssertEqual(sut.validate(text: "abc"), .success)
    }

    func testValidationSuccessMinimumValue() {
        XCTAssertEqual(sut.validate(text: "a"), .success)
    }

    func testValidationFailure() {
        XCTAssertEqual(sut.validate(text: ""), .failure(message: errorMessage))
    }

    func testValidationSuccessDoNotIgnoreSpaces() {
        ignoreSpaces = false
        XCTAssertEqual(sut.validate(text: " "), .success)
    }

    func testValidationFailureIgnoreSpaces() {
        XCTAssertEqual(sut.validate(text: " "), .failure(message: errorMessage))
    }
}
