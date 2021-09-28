//
//  DateExtensionTests.swift
//  Core
//
//  Created by Mariusz Sut on 28/09/2021.
//

import Foundation
import XCTest

@testable import Core

final class DateExtensionTests: XCTestCase {
    private var year = 2000
    private var month = 10
    private var day = 20
    private lazy var sut = Date.from(year: year, month: month, day: day)

    func testInitFromSuccess() {
        let components = NSCalendar.current.dateComponents([.year, .month, .day], from: sut)
        XCTAssertEqual(components.year, year)
        XCTAssertEqual(components.month, month)
        XCTAssertEqual(components.day, day)
    }

    func testFormat_ddMMyyyy() {
        XCTAssertEqual(sut.ddMMyyyy, "\(day)-\(month)-\(year)")
    }
}
