//
//  TextFieldCellViewModel.swift
//  Journey
//
//  Created by Mariusz Sut on 22/10/2021.
//

import Core
import UIKit
import RxDataSources

struct TextFieldCellViewModel {
    let uuid: String
    let title: String
    let placeholder: String
    let helper: String
    let error: String?
}

// MARK: - Equatable
extension TextFieldCellViewModel: Equatable { /*Nop*/ }

// MARK: - IdentifiableType
extension TextFieldCellViewModel: IdentifiableType {
    var identity: String {
        uuid
    }
}
