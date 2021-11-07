//
//  TagViewTests.swift
//  Core
//
//  Created by Mariusz Sut on 31/10/2021.
//

import SnapshotTesting
import XCTest
import TestKit

@testable import Core

final class TagViewTests: XCTestCase {
    private var mode = UIUserInterfaceStyle.light
    private var titleText = ""
    private var emptyText = ""
    private var errorText = ""
    private var helperText = ""
    private var items: [TagViewItem] = []
    private lazy var sut: TagView = {
        let view = TagView(layout: CompositionalLayoutFactory().tagView(itemSpacing: Spacings.normal))
        view.titleText = titleText
        view.emptyText = emptyText
        view.errorText = errorText
        view.helperText = helperText
        view.items = items
        return view
    }()
    private lazy var container = UIView.container(sut: sut, mode: mode, size: CGSize(width: 376, height: 0),
                                                  backgroundColor: Assets.Colors.Core.Background.primary)

    // MARK: - Default
    func testDefault() {
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    // MARK: - Title
    func testTitle() {
        titleText = LoremIpsum.long
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testTitleAndEmpty() {
        titleText = LoremIpsum.long
        emptyText = LoremIpsum.long
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testTitleAndEmptyAndError() {
        titleText = LoremIpsum.long
        emptyText = LoremIpsum.long
        errorText = LoremIpsum.long
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testTitleAndEmptyAndErrorAndHelper() {
        titleText = LoremIpsum.long
        emptyText = LoremIpsum.long
        errorText = LoremIpsum.long
        helperText = LoremIpsum.long
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testTitleAndError() {
        titleText = LoremIpsum.long
        errorText = LoremIpsum.long
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testTitleAndHelper() {
        titleText = LoremIpsum.long
        helperText = LoremIpsum.long
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    // MARK: - Empty
    func testEmpty() {
        emptyText = LoremIpsum.long
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testEmptyAndError() {
        emptyText = LoremIpsum.long
        errorText = LoremIpsum.long
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testEmptyAndErrorAndHelper() {
        emptyText = LoremIpsum.long
        errorText = LoremIpsum.long
        helperText = LoremIpsum.long
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testEmptyAndHelper() {
        emptyText = LoremIpsum.long
        helperText = LoremIpsum.long
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    // MARK: - Error
    func testError() {
        errorText = LoremIpsum.long
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testErrorAndHelper() {
        errorText = LoremIpsum.long
        helperText = LoremIpsum.long
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    // MARK: - Helper
    func testHelper() {
        helperText = LoremIpsum.long
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    // MARK: - Items
    func testOneItemOnly() {
        items = [.mock("Mariusz")]
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testTitleAndOneItem() {
        titleText = LoremIpsum.long
        items = [.mock("Mariusz")]
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testSomeItemsOnly() {
        items = ["Jan", "Paweł", "Tomek", "Andrzej", "Donald", "Kuba", "Eustachy"].map { .mock($0) }
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testTitleAndSomeItems() {
        titleText = LoremIpsum.long
        items = ["Jan", "Paweł", "Tomek", "Andrzej", "Donald", "Kuba", "Eustachy"].map { .mock($0) }
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testFullLightMode() {
        titleText = LoremIpsum.long
        emptyText = LoremIpsum.long
        items = ["Jan", "Paweł", "Tomek", "Andrzej", "Donald", "Kuba", "Eustachy"].map { .mock($0) }
        errorText = LoremIpsum.long
        helperText = LoremIpsum.long
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }

    func testFullDarktMode() {
        mode = .dark
        titleText = LoremIpsum.long
        emptyText = LoremIpsum.long
        items = ["Jan", "Paweł", "Tomek", "Andrzej", "Donald", "Kuba", "Eustachy"].map { .mock($0) }
        errorText = LoremIpsum.long
        helperText = LoremIpsum.long
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }
}

extension TagViewItem {
    static func mock(_ text: String) -> TagViewItem {
        .deletable(viewModel: .init(uuid: text, text: text, disabled: false))
    }
}
