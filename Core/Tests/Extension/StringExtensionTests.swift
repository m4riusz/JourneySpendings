//
//  StringExtensionTests.swift
//  Core
//
//  Created by Mariusz Sut on 10/10/2021.
//

import Foundation
import XCTest

@testable import Core

final class StringExtensionTests: XCTestCase {
    private var sut: String?

    func testIsNilOrEmptyWhenNil() {
        XCTAssertTrue(sut.isNilOrEmpty, "Should return `true` when nil")
    }

    func testIsNilOrEmptyWhenEmpty() {
        sut = ""
        XCTAssertTrue(sut.isNilOrEmpty, "Should return `true` when empty")
    }

    func testIsNilOrEmptyWhenNotEmpty() {
        sut = "abc"
        XCTAssertFalse(sut.isNilOrEmpty, "Should return `false` when not empty")
    }

    func testIsNilOrEmptyWhenBlank() {
        sut = "    "
        XCTAssertFalse(sut.isNilOrEmpty, "Should return `false` when blank")
    }

    func testIsNilOrBlankWhenNil() {
        XCTAssertTrue(sut.isNilOrBlank, "Should return `true` when nil")
    }

    func testIsNilOrBlankWhenEmpty() {
        sut = ""
        XCTAssertTrue(sut.isNilOrBlank, "Should return `true` when empty")
    }

    func testIsNilOrBlankWhenBlank() {
        sut = "   "
        XCTAssertTrue(sut.isNilOrBlank, "Should return `true` when blank")
    }

    func testIsNilOrBlankWhenNotBlank() {
        sut = "abc"
        XCTAssertFalse(sut.isNilOrBlank, "Should return `false` when not blank")
    }
}
