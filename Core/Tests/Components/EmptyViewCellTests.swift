//
//  EmptyViewCellTests.swift
//  Core
//
//  Created by Mariusz Sut on 03/10/2021.
//

import SnapshotTesting
import XCTest
import TestKit

@testable import Core

final class EmptyViewCellTests: XCTestCase {
    private var mode = UIUserInterfaceStyle.light
    private var image = Assets.Images.Core.bagSuitcaseOutline
    private var titleText = "Title"
    private var descriptionText = "Description"
    private lazy var viewModel = EmptyViewCellViewModel(image: image,
                                                        title: titleText,
                                                        description: descriptionText)
    private lazy var sut: EmptyViewCell = {
        let cell = EmptyViewCell()
        cell.load(viewModel: viewModel)
        return cell
    }()
    private lazy var container = UIView.cellContainer(sut: sut, mode: mode,
                                                      backgroundColor: Assets.Colors.Core.Background.primary)

    func testShorTextsLightMode() {
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testShorTextsDarkMode() {
        mode = .dark
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testLongTextsLightMode() {
        titleText = LoremIpsum.long
        descriptionText = LoremIpsum.veryLong
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testLongTextsDarkMode() {
        mode = .dark
        titleText = LoremIpsum.long
        descriptionText = LoremIpsum.veryLong
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }
}
