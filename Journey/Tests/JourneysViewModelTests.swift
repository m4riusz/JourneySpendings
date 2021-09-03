//
//  JourneysViewModelTests.swift
//  JourneyTests
//
//  Created by Mariusz Sut on 03/09/2021.
//

import XCTest
@testable import Journey

final class JourneysViewModelTests: XCTestCase {
    private lazy var sut = JourneysViewModel()
    
    func testSample() {
        XCTAssertNil(sut.coordinator)
    }
}
