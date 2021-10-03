//
//  AmountTests.swift
//  Core
//
//  Created by Mariusz Sut on 29/09/2021.
//

import Foundation
import XCTest

@testable import Core

final class AmountTests: XCTestCase {
    private var value = 100.0
    private var currency = "zł"
    private lazy var sut = Amount(value: value, currency: currency)

    func testSmallNumber() {
        XCTAssertEqual(sut.formated(), "100,00 zł")
    }

    func testBigNumber() {
        value = 1000000
        XCTAssertEqual(sut.formated(), "1 000 000,00 zł")
    }

    func testZero() {
        value = 0
        XCTAssertEqual(sut.formated(), "0,00 zł")
    }

    func testNegativeNumber() {
        value = -100
        XCTAssertEqual(sut.formated(), "-100,00 zł")
    }

    func testNumberEmptyCurrency() {
        currency = ""
        XCTAssertEqual(sut.formated(), "100,00")
    }

    func testNumberFraction1() {
        value = 100.51
        XCTAssertEqual(sut.formated(), "100,51 zł")
    }

    func testNumberFraction2() {
        value = 100.7
        XCTAssertEqual(sut.formated(), "100,70 zł")
    }

    func testBigNumberWithFraction() {
        value = 1000000.7
        XCTAssertEqual(sut.formated(), "1 000 000,70 zł")
    }

    func testNegativeNumberNoCurrency() {
        value = -100.5
        currency = ""
        XCTAssertEqual(sut.formated(), "-100,50")
    }

    func testNegativeNumberWithFraction1() {
        value = -100.5
        XCTAssertEqual(sut.formated(), "-100,50 zł")
    }

    func testNegativeNumberWithFraction2() {
        value = -100.77
        XCTAssertEqual(sut.formated(), "-100,77 zł")
    }

    func testNegativeBigNumberWithFraction() {
        value = -1000000.77
        XCTAssertEqual(sut.formated(), "-1 000 000,77 zł")
    }
}
