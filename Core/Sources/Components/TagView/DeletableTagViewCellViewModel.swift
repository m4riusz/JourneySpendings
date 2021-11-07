//
//  DeletableTagViewCellViewModel.swift
//  Core
//
//  Created by Mariusz Sut on 26/10/2021.
//

import Foundation

public struct DeletableTagViewCellViewModel {
    let uuid: String
    let text: String
    let disabled: Bool

    public init(uuid: String = UUID().uuidString, text: String, disabled: Bool = false) {
        self.uuid = uuid
        self.text = text
        self.disabled = disabled
    }
}

// MARK: - Equatable
extension DeletableTagViewCellViewModel: Equatable { /*Nop*/ }
