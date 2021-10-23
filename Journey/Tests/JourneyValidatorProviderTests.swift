//
//  JourneyValidatorProviderTests.swift
//  Journey
//
//  Created by Mariusz Sut on 23/10/2021.
//

import Core
import XCTest
@testable import Journey

final class JourneyValidatorProviderTests: XCTestCase {
    private typealias Literals = Assets.Strings.Journey.Create.Name.Error
    private lazy var sut = JourneyValidatorProvider()

    func testJourneyNameValidatorMinLength() {
        XCTAssertEqual(sut.journeyNameValidator.validate(text: "1234"), .success)
    }

    func testJourneyNameValidatorMaxLength() {
        let text = String(repeating: "A", count: 40)
        XCTAssertEqual(sut.journeyNameValidator.validate(text: text), .success)
    }

    func testJourneyNameValidatorToShort() {
        XCTAssertEqual(sut.journeyNameValidator.validate(text: "123"), .failure(message: Literals.tooShort))
    }

    func testJourneyNameValidatorToLong() {
        let text = String(repeating: "A", count: 41)
        XCTAssertEqual(sut.journeyNameValidator.validate(text: text), .failure(message: Literals.tooLong))
    }

    func testJourneyNameValidatorBlank() {
        XCTAssertEqual(sut.journeyNameValidator.validate(text: "         "), .failure(message: Literals.tooShort))
    }
}
