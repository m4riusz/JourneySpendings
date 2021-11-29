//
//  TableViewSectionTests.swift
//  Core
//
//  Created by Sut, Mariusz, (mBank/DBI) on 29/11/2021.
//

import SnapshotTesting
import XCTest
import TestKit

@testable import Core

final class TableViewSectionTests: XCTestCase {
    private var mode: UIUserInterfaceStyle = .light
    private var title = "title"
    private var button: String? = "button"
    private lazy var sut: TableViewSection = {
        let view = TableViewSection(reuseIdentifier: "")
        view.load(viewModel: TableViewSectionViewModel(title: title, button: button))
        return view
    }()
    private lazy var container = UIView.container(sut: sut, mode: mode, size: CGSize(width: 370, height: 0),
                                                  backgroundColor: Assets.Colors.Core.Background.primary)

    func testTitleAndButtonLightMode() {
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }
    
    func testTitleAndButtonDarkMode() {
        mode = .dark
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }
    
    func testTitleOnly() {
        button = nil
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }
    
    func testTitleOnly2() {
        button = ""
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }
    
    func testButtonOnly() {
        title = ""
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }
    
    func testNoTitleAndNoButton() {
        title = ""
        button = ""
        assertSnapshot(matching: container, as: .standardPrecissionImage)
    }
}
