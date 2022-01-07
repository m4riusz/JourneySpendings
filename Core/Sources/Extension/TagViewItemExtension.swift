//
//  TagViewItemExtension.swift
//  Core
//
//  Created by Mariusz Sut on 07/01/2022.
//

import Foundation

public extension Array where Element == TagViewItem {
    var selectableItems: [SelectableTagViewCellViewModel] {
        compactMap { item -> SelectableTagViewCellViewModel? in
            guard case let .selectable(model) = item else { return nil }
            return model
        }
    }

    var selectedItemUuids: [String] {
        selectableItems.filter { $0.selected }.compactMap { $0.uuid }
    }
}
