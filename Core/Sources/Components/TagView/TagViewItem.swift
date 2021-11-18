//
//  TagViewItem.swift
//  Core
//
//  Created by Mariusz Sut on 30/10/2021.
//

import Foundation

public enum TagViewItem {
    case deletable(viewModel: DeletableTagViewCellViewModel)
    case selectable(viewModel: SelectableTagViewCellViewModel)
}

public extension TagViewItem {
    var uuid: String {
        switch self {
        case .deletable(let viewModel): return viewModel.uuid
        case .selectable(let viewModel): return viewModel.uuid
        }
    }
    var text: String? {
        switch self {
        case .deletable(let viewModel): return viewModel.text
        case .selectable(let viewModel): return viewModel.text
        }
    }
}

extension TagViewItem: Equatable { /*Nop*/ }
