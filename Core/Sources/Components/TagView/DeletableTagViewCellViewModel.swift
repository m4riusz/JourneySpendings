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

    public init(uuid: String, text: String, disabled: Bool) {
        self.uuid = uuid
        self.text = text
        self.disabled = disabled
    }
}
