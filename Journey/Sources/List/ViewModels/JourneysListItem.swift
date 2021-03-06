//
//  JourneysListItem.swift
//  Journey
//
//  Created by Mariusz Sut on 03/10/2021.
//

import Core
import RxDataSources

enum JourneysListItem {
    case journey(viewModel: JourneysItemCellViewModel)
    case empty(viewModel: EmptyViewCellViewModel)
}

// MARK: - IdentifiableType
extension JourneysListItem: IdentifiableType {
    var identity: AnyHashable {
        switch self {
        case .journey(let viewModel): return viewModel.identity
        case .empty(let viewModel): return viewModel.identity
        }
    }
}

// MARK: - Equatable
extension JourneysListItem: Equatable { /*Nop*/ }
