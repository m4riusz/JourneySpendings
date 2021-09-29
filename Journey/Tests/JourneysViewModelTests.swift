//
//  JourneysViewModelTests.swift
//  JourneyTests
//
//  Created by Mariusz Sut on 03/09/2021.
//

import XCTest
@testable import Journey

final class JourneysViewModelTests: XCTestCase {
    private let repository = JourneyRepositoryMock()
    private lazy var sut = JourneysViewModel(repository: repository)

    func testSample() {
        XCTAssertNil(sut.coordinator)
    }
    // TODO: - add RxTest && rest of the tests
}
