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
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testPrimaryHighlitedLightMode() {
        sut.style = .primary
        sut.isHighlighted = true
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testPrimaryDisabledLightMode() {
        sut.style = .primary
        sut.isEnabled = false
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testPrimaryNormalDarkMode() {
        mode = .dark
        sut.style = .primary
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testPrimaryHighlitedDarkMode() {
        mode = .dark
        sut.style = .primary
        sut.isHighlighted = true
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testPrimaryDisabledDarkMode() {
        mode = .dark
        sut.style = .primary
        sut.isEnabled = false
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testSecondaryNormalLightMode() {
        sut.style = .secondary
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testSecondaryHighlitedLightMode() {
        sut.style = .secondary
        sut.isHighlighted = true
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testSecondaryDisabledLightMode() {
        sut.style = .secondary
        sut.isEnabled = false
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testSecondaryNormalDarkMode() {
        mode = .dark
        sut.style = .secondary
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testSecondaryHighlitedDarkMode() {
        mode = .dark
        sut.style = .secondary
        sut.isHighlighted = true
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testSecondaryDisabledDarkMode() {
        mode = .dark
        sut.style = .secondary
        sut.isEnabled = false
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testTertiaryNormalLightMode() {
        sut.style = .tertiary
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testTertiaryHighlitedLightMode() {
        sut.style = .tertiary
        sut.isHighlighted = true
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testTertiaryDisabledLightMode() {
        sut.style = .tertiary
        sut.isEnabled = false
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testTertiaryNormalDarkMode() {
        mode = .dark
        sut.style = .tertiary
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testTertiaryHighlitedDarkMode() {
        mode = .dark
        sut.style = .tertiary
        sut.isHighlighted = true
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testTertiaryDisabledDarkMode() {
        mode = .dark
        sut.style = .tertiary
        sut.isEnabled = false
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

}

// TODO: - Create TestKit target and move this code to it
extension Snapshotting where Value == UIView, Format == UIImage {
  public static var standardPrecissionImage: Snapshotting {
      .image(drawHierarchyInKeyWindow: true, precision: 0.99)
  }
}
