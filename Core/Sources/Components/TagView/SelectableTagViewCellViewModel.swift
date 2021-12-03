//
//  SelectableTagViewCellViewModel.swift
//  Core
//
//  Created by Sut, Mariusz, (mBank/DBI) on 18/11/2021.
//

import Foundation

public struct SelectableTagViewCellViewModel {
    public let uuid: String
    public let text: String
    public let selected: Bool

    public init(uuid: String = UUID().uuidString, text: String, selected: Bool = false) {
        self.uuid = uuid
        self.text = text
        self.selected = selected
    }
}

// MARK: - Equatable
extension SelectableTagViewCellViewModel: Equatable { /*Nop*/ }
