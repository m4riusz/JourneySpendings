//
//  EmptyViewCellTests.swift
//  Core
//
//  Created by Mariusz Sut on 03/10/2021.
//

import SnapshotTesting
import XCTest

@testable import Core

final class EmptyViewCellTests: XCTestCase {
    private var mode = UIUserInterfaceStyle.light
    private var image = Assets.Images.Core.bagSuitcaseOutline
    private var titleText = "Title"
    private var descriptionText = "Description"
    private var buttonText = "ACTION"
    private lazy var viewModel = EmptyViewCellViewModel(image: image,
                                                        title: titleText,
                                                        description: descriptionText,
                                                        buttonText: buttonText)
    private lazy var sut: EmptyViewCell = {
        let cell = EmptyViewCell()
        cell.load(viewModel: viewModel)
        return cell
    }()
    private lazy var container = UIView.cellContainer(sut: sut, mode: mode)

    func testShorTextsLightMode() {
        assertSnapshot(matching: container, as: .image)
    }

    func testShorTextsDarkMode() {
        mode = .dark
        assertSnapshot(matching: container, as: .image)
    }

    func testLongTextsLightMode() {
        titleText = LoremIpsum.long
        descriptionText = LoremIpsum.veryLong
        buttonText = LoremIpsum.long
        assertSnapshot(matching: container, as: .image)
    }

    func testLongTextsDarkMode() {
        mode = .dark
        titleText = LoremIpsum.long
        descriptionText = LoremIpsum.veryLong
        buttonText = LoremIpsum.long
        assertSnapshot(matching: container, as: .image)
    }
}
