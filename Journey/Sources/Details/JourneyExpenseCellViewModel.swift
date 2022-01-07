//
//  JourneyExpenseCellViewModel.swift
//  Journey
//
//  Created by Sut, Mariusz, (mBank/DBI) on 01/12/2021.
//

import RxDataSources

struct JourneyExpenseCellViewModel {
    let uuid: String
    let title: String
    let persons: String
    let cost: String
}

// MARK: - Equatable
extension JourneyExpenseCellViewModel: Equatable { /*Nop*/ }

// MARK: - IdentifiableType
extension JourneyExpenseCellViewModel: IdentifiableType {
    var identity: String {
        uuid
    }
}
