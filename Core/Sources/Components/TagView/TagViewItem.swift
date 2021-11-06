//
//  TagViewItem.swift
//  Core
//
//  Created by Mariusz Sut on 30/10/2021.
//

import Foundation

public enum TagViewItem {
    case deletable(viewModel: DeletableTagViewCellViewModel)
}

public extension TagViewItem {
    var text: String? {
        switch self {
        case .deletable(let viewModel):
            return viewModel.text
        }
    }
}
