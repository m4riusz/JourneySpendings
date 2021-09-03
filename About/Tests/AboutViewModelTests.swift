//
//  AboutViewModelTests.swift
//  AboutTests
//
//  Created by Mariusz Sut on 03/09/2021.
//

import XCTest
@testable import About

final class AboutViewModelTests: XCTestCase {
    private lazy var sut = AboutViewModel()
    
    func testSample() {
        XCTAssertNil(sut.coordinator)
    }
}
