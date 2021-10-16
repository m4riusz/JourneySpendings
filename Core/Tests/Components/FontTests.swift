//
// FontTests.swift
// Core
//
// CreatedbyMariuszSuton03/10/2021.
//

import SnapshotTesting
import XCTest
import TestKit

@testable import Core

final class FontTests: XCTestCase {
    private var views: [UIView] = []
    private var mode: UIUserInterfaceStyle = .light
    private var text = "aąbcćdeęfghijklłmnńoóprsśtuwyzźżAĄBCĆDEĘFGHIJKLŁMNŃOÓPRSŚTUWYZŹŻ0123456789"
    private lazy var sut: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .vertical
        return stackView
    }()
    private lazy var container = UIView.container(sut: sut, mode: mode,
                                                  backgroundColor: Assets.Colors.Core.Background.primary)

    func testStylesLightMode() {
        views = FontStyles.allCases.map { label(text: text.styled($0)) }
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testStylesDarkMode() {
        mode = .dark
        views = FontStyles.allCases.map { label(text: text.styled($0)) }
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    private func label(text: NSAttributedString) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = text
        return label
    }
}
