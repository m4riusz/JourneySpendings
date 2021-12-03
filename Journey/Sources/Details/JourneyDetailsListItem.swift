//
//  JourneyDetailsListItem.swift
//  Journey
//
//  Created by Sut, Mariusz, (mBank/DBI) on 30/11/2021.
//

import Core
import RxDataSources

enum JourneyDetailsListItem {
    case expense(viewModel: JourneyExpenseCellViewModel)
}

// MARK: - IdentifiableType
extension JourneyDetailsListItem: IdentifiableType {
    var identity: AnyHashable {
        switch self {
        case .expense(let viewModel): return viewModel.uuid
        }
    }
}

// MARK: - Equatable
extension JourneyDetailsListItem: Equatable { /*Nop*/ }
