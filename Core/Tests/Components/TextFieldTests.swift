//
//  TextFieldTests.swift
//  Core
//
//  Created by Mariusz Sut on 15/10/2021.
//

import SnapshotTesting
import XCTest
import TestKit

@testable import Core

final class TextFieldTests: XCTestCase {
    private var mode = UIUserInterfaceStyle.light
    private var title = ""
    private var text = ""
    private var placeholder = ""
    private var error = ""
    private var helper = ""
    private lazy var sut: TextField = {
        let textField = TextField()
        textField.titleText = title
        textField.text = text
        textField.placeholder = placeholder
        textField.errorText = error
        textField.helperText = helper
        return textField
    }()
    private lazy var container = UIView.container(sut: sut, mode: mode, size: CGSize(width: 375, height: 0),
                                                  backgroundColor: Assets.Colors.Core.Background.primary)

    // MARK: - Plain
    func testPlainLightMode() {
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testPlainDarkMode() {
        mode = .dark
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    // MARK: - Text
    func testTextLightMode() {
        text = LoremIpsum.long
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testTextDarkMode() {
        mode = .dark
        text = LoremIpsum.long
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    // MARK: - Title
    func testTitleLightMode() {
        title = LoremIpsum.long
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testTitleDarkMode() {
        mode = .dark
        title = LoremIpsum.long
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    // MARK: - Placeholder
    func testPlaceholderLightMode() {
        placeholder = LoremIpsum.long
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testPlaceholderDarkMode() {
        mode = .dark
        placeholder = LoremIpsum.long
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    // MARK: - Error
    func testErrorLightMode() {
        error = LoremIpsum.long
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testErrorDarkMode() {
        mode = .dark
        error = LoremIpsum.long
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    // MARK: - Helper
    func testHelperLightMode() {
        helper = LoremIpsum.long
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testHelperDarkMode() {
        mode = .dark
        helper = LoremIpsum.long
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    // MARK: - Title & Placeholder
    func testTitleAndPlaceholderLightMode() {
        title = LoremIpsum.long
        placeholder = LoremIpsum.long
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testTitleAndPlaceholderDarkMode() {
        mode = .dark
        title = LoremIpsum.long
        placeholder = LoremIpsum.long
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    // MARK: - Title & Error
    func testTitleAndErrorLightMode() {
        title = LoremIpsum.long
        error = LoremIpsum.long
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testTitleAndErrorDarkMode() {
        mode = .dark
        title = LoremIpsum.long
        error = LoremIpsum.long
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    // MARK: - Title & Helper
    func testTitleAndHelperLightMode() {
        title = LoremIpsum.long
        helper = LoremIpsum.long
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testTitleAndHelperDarkMode() {
        mode = .dark
        title = LoremIpsum.long
        helper = LoremIpsum.long
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    // MARK: - Title & Text & Helper
    func testTitleAndTextAndHelperLightMode() {
        title = LoremIpsum.long
        text = LoremIpsum.long
        helper = LoremIpsum.long
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testTitleAndTextAndHelperDarkMode() {
        mode = .dark
        title = LoremIpsum.long
        text = LoremIpsum.long
        helper = LoremIpsum.long
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    // MARK: - Full
    func testFullLightMode() {
        title = LoremIpsum.long
        placeholder = LoremIpsum.long
        text = LoremIpsum.long
        helper = LoremIpsum.long
        error = LoremIpsum.long
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testFullDarkMode() {
        mode = .dark
        title = LoremIpsum.long
        placeholder = LoremIpsum.long
        text = LoremIpsum.long
        helper = LoremIpsum.long
        error = LoremIpsum.long
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }
}
