//
//  JourneyDetailsListItem.swift
//  Journey
//
//  Created by Sut, Mariusz, (mBank/DBI) on 30/11/2021.
//

import Core
import RxDataSources

enum JourneyDetailsListItem {
    case expenses
}

// MARK: - IdentifiableType
extension JourneyDetailsListItem: IdentifiableType {
    var identity: AnyHashable {
        switch self {
        case .expenses: return ""
        }
    }
}

// MARK: - Equatable
extension JourneyDetailsListItem: Equatable { /*Nop*/ }
