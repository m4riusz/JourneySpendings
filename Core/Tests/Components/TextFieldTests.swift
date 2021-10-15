//
//  TextFieldTests.swift
//  Core
//
//  Created by Mariusz Sut on 15/10/2021.
//

import SnapshotTesting
import XCTest

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
    private lazy var container = UIView.container(sut: sut, mode: mode, size: CGSize(width: 375, height: 0))

    // MARK: - Plain
    func testPlainLightMode() {
        assertSnapshot(matching: container, as: .image)
    }

    func testPlainDarkMode() {
        mode = .dark
        assertSnapshot(matching: container, as: .image)
    }

    // MARK: - Text
    func testTextLightMode() {
        text = LoremIpsum.long
        assertSnapshot(matching: container, as: .image)
    }

    func testTextDarkMode() {
        mode = .dark
        text = LoremIpsum.long
        assertSnapshot(matching: container, as: .image)
    }

    // MARK: - Title
    func testTitleLightMode() {
        title = LoremIpsum.long
        assertSnapshot(matching: container, as: .image)
    }

    func testTitleDarkMode() {
        mode = .dark
        title = LoremIpsum.long
        assertSnapshot(matching: container, as: .image)
    }

    // MARK: - Placeholder
    func testPlaceholderLightMode() {
        placeholder = LoremIpsum.long
        assertSnapshot(matching: container, as: .image)
    }

    func testPlaceholderDarkMode() {
        mode = .dark
        placeholder = LoremIpsum.long
        assertSnapshot(matching: container, as: .image)
    }

    // MARK: - Error
    func testErrorLightMode() {
        error = LoremIpsum.long
        assertSnapshot(matching: container, as: .image)
    }

    func testErrorDarkMode() {
        mode = .dark
        error = LoremIpsum.long
        assertSnapshot(matching: container, as: .image)
    }

    // MARK: - Helper
    func testHelperLightMode() {
        helper = LoremIpsum.long
        assertSnapshot(matching: container, as: .image)
    }

    func testHelperDarkMode() {
        mode = .dark
        helper = LoremIpsum.long
        assertSnapshot(matching: container, as: .image)
    }

    // MARK: - Title & Placeholder
    func testTitleAndPlaceholderLightMode() {
        title = LoremIpsum.long
        placeholder = LoremIpsum.long
        assertSnapshot(matching: container, as: .image)
    }

    func testTitleAndPlaceholderDarkMode() {
        mode = .dark
        title = LoremIpsum.long
        placeholder = LoremIpsum.long
        assertSnapshot(matching: container, as: .image)
    }

    // MARK: - Title & Error
    func testTitleAndErrorLightMode() {
        title = LoremIpsum.long
        error = LoremIpsum.long
        assertSnapshot(matching: container, as: .image)
    }

    func testTitleAndErrorDarkMode() {
        mode = .dark
        title = LoremIpsum.long
        error = LoremIpsum.long
        assertSnapshot(matching: container, as: .image)
    }

    // MARK: - Title & Helper
    func testTitleAndHelperLightMode() {
        title = LoremIpsum.long
        helper = LoremIpsum.long
        assertSnapshot(matching: container, as: .image)
    }

    func testTitleAndHelperDarkMode() {
        mode = .dark
        title = LoremIpsum.long
        helper = LoremIpsum.long
        assertSnapshot(matching: container, as: .image)
    }

    // MARK: - Title & Text & Helper
    func testTitleAndTextAndHelperLightMode() {
        title = LoremIpsum.long
        text = LoremIpsum.long
        helper = LoremIpsum.long
        assertSnapshot(matching: container, as: .image)
    }

    func testTitleAndTextAndHelperDarkMode() {
        mode = .dark
        title = LoremIpsum.long
        text = LoremIpsum.long
        helper = LoremIpsum.long
        assertSnapshot(matching: container, as: .image)
    }

    // MARK: - Full
    func testFullLightMode() {
        title = LoremIpsum.long
        placeholder = LoremIpsum.long
        text = LoremIpsum.long
        helper = LoremIpsum.long
        error = LoremIpsum.long
        assertSnapshot(matching: container, as: .image)
    }

    func testFullDarkMode() {
        mode = .dark
        title = LoremIpsum.long
        placeholder = LoremIpsum.long
        text = LoremIpsum.long
        helper = LoremIpsum.long
        error = LoremIpsum.long
        assertSnapshot(matching: container, as: .image)
    }
}
