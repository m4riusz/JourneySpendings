//
//  SelectableTagViewCellViewModel.swift
//  Core
//
//  Created by Sut, Mariusz, (mBank/DBI) on 18/11/2021.
//

import Foundation

public struct SelectableTagViewCellViewModel {
    let uuid: String
    let text: String
    let selected: Bool

    public init(uuid: String = UUID().uuidString, text: String, selected: Bool = false) {
        self.uuid = uuid
        self.text = text
        self.selected = selected
    }
}

// MARK: - Equatable
extension SelectableTagViewCellViewModel: Equatable { /*Nop*/ }
