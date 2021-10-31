//
//  DeletableTagViewCellTests.swift
//  Core
//
//  Created by Mariusz Sut on 31/10/2021.
//

import SnapshotTesting
import XCTest
import TestKit

@testable import Core

final class DeletableTagViewCellTests: XCTestCase {
    private var mode = UIUserInterfaceStyle.light
    private var size: CGSize = .zero
    private var text = "Text"
    private var disabled = false
    private lazy var viewModel = DeletableTagViewCellViewModel(uuid: "1", text: text, disabled: disabled)
    private lazy var sut: DeletableTagViewCell = {
        let cell = DeletableTagViewCell()
        cell.load(viewModel: viewModel)
        return cell
    }()
    private lazy var container = UIView.cellContainer(sut: sut,
                                                      size: size,
                                                      mode: mode,
                                                      insets: .init(all: 8),
                                                      backgroundColor: Assets.Colors.Core.Background.primary)

    func testLightMode() {
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testLightModeDisabled() {
        disabled = true
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testDarkMode() {
        mode = .dark
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testDarkModeDisabled() {
        mode = .dark
        disabled = true
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testLongText() {
        text = LoremIpsum.long
        size = CGSize(width: 100, height: 0)
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }
}
