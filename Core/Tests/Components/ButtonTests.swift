//
//  ButtonTests.swift
//  Core
//
//  Created by Mariusz Sut on 22/09/2021.
//

import SnapshotTesting
import XCTest

@testable import Core

final class ButtonTests: XCTestCase {
    private var mode = UIUserInterfaceStyle.light
    private lazy var sut = Button(text: "BUTTON")
    private lazy var container = UIView.container(sut: sut, mode: mode)

    func testPrimaryNormalLightMode() {
        sut.style = .primary
        assertSnapshot(matching: container, as: .image)
    }

    func testPrimaryHighlitedLightMode() {
        sut.style = .primary
        sut.isHighlighted = true
        assertSnapshot(matching: container, as: .image)
    }

    func testPrimaryDisabledLightMode() {
        sut.style = .primary
        sut.isEnabled = false
        assertSnapshot(matching: container, as: .image)
    }

    func testPrimaryNormalDarkMode() {
        mode = .dark
        sut.style = .primary
        assertSnapshot(matching: container, as: .image)
    }

    func testPrimaryHighlitedDarkMode() {
        mode = .dark
        sut.style = .primary
        sut.isHighlighted = true
        assertSnapshot(matching: container, as: .image)
    }

    func testPrimaryDisabledDarkMode() {
        mode = .dark
        sut.style = .primary
        sut.isEnabled = false
        assertSnapshot(matching: container, as: .image)
    }

    func testSecondaryNormalLightMode() {
        sut.style = .secondary
        assertSnapshot(matching: container, as: .image(precision: 0.95))
    }

    func testSecondaryHighlitedLightMode() {
        sut.style = .secondary
        sut.isHighlighted = true
        assertSnapshot(matching: container, as: .image(precision: 0.95))
    }

    func testSecondaryDisabledLightMode() {
        sut.style = .secondary
        sut.isEnabled = false
        assertSnapshot(matching: container, as: .image)
    }

    func testSecondaryNormalDarkMode() {
        mode = .dark
        sut.style = .secondary
        assertSnapshot(matching: container, as: .image(precision: 0.95))
    }

    func testSecondaryHighlitedDarkMode() {
        mode = .dark
        sut.style = .secondary
        sut.isHighlighted = true
        assertSnapshot(matching: container, as: .image(precision: 0.95))
    }

    func testSecondaryDisabledDarkMode() {
        mode = .dark
        sut.style = .secondary
        sut.isEnabled = false
        assertSnapshot(matching: container, as: .image)
    }

    func testTertiaryNormalLightMode() {
        sut.style = .tertiary
        assertSnapshot(matching: container, as: .image)
    }

    func testTertiaryHighlitedLightMode() {
        sut.style = .tertiary
        sut.isHighlighted = true
        assertSnapshot(matching: container, as: .image)
    }

    func testTertiaryDisabledLightMode() {
        sut.style = .tertiary
        sut.isEnabled = false
        assertSnapshot(matching: container, as: .image)
    }

    func testTertiaryNormalDarkMode() {
        mode = .dark
        sut.style = .tertiary
        assertSnapshot(matching: container, as: .image)
    }

    func testTertiaryHighlitedDarkMode() {
        mode = .dark
        sut.style = .tertiary
        sut.isHighlighted = true
        assertSnapshot(matching: container, as: .image)
    }

    func testTertiaryDisabledDarkMode() {
        mode = .dark
        sut.style = .tertiary
        sut.isEnabled = false
        assertSnapshot(matching: container, as: .image)
    }

}
