//
//  JourneyCreateListItem.swift
//  Journey
//
//  Created by Mariusz Sut on 22/10/2021.
//

import Core
import RxDataSources

enum JourneyCreateListItem {
    case name(viewModel: TextFieldCellViewModel)
}

// MARK: - IdentifiableType
extension JourneyCreateListItem: IdentifiableType {
    var identity: AnyHashable {
        switch self {
        case .name(let viewModel): return viewModel.identity
        }
    }
}

// MARK: - Equatable
extension JourneyCreateListItem: Equatable { /*Nop*/ }
