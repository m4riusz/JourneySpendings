//
//  ButtonTests.swift
//  Core
//
//  Created by Mariusz Sut on 22/09/2021.
//

import SnapshotTesting
import XCTest

@testable import Core

extension UIEdgeInsets {
    init(all value: CGFloat) {
        self.init(top: value, left: value, bottom: -value, right: -value)
    }
}

extension UIView {
    static func container(sut: UIView,
                          mode: UIUserInterfaceStyle = .light,
                          size: CGSize = .zero,
                          insets: UIEdgeInsets = .init(all: 8),
                          backgroundColor: UIColor = Assets.Colors.Core.Background.primary) -> UIView {
        let view = UIView()
        view.backgroundColor = backgroundColor
        view.addSubview(sut)
        view.translatesAutoresizingMaskIntoConstraints = false
        sut.translatesAutoresizingMaskIntoConstraints = false
        sut.topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top).isActive = true
        sut.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left).isActive = true
        sut.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right).isActive = true
        sut.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom).isActive = true
        if size.width > 0 {
            sut.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height > 0 {
            sut.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        view.layoutSubviews()
        view.overrideUserInterfaceStyle = mode
        return view
    }
}

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
        assertSnapshot(matching: container, as: .image)
    }

    func testSecondaryHighlitedLightMode() {
        sut.style = .secondary
        sut.isHighlighted = true
        assertSnapshot(matching: container, as: .image)
    }

    func testSecondaryDisabledLightMode() {
        sut.style = .secondary
        sut.isEnabled = false
        assertSnapshot(matching: container, as: .image)
    }

    func testSecondaryNormalDarkMode() {
        mode = .dark
        sut.style = .secondary
        assertSnapshot(matching: container, as: .image)
    }

    func testSecondaryHighlitedDarkMode() {
        mode = .dark
        sut.style = .secondary
        sut.isHighlighted = true
        assertSnapshot(matching: container, as: .image)
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
