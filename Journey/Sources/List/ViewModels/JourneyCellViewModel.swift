//
//  JourneyCellViewModel.swift
//  Journey
//
//  Created by Mariusz Sut on 25/09/2021.
//

import RxDataSources

struct JourneysItemCellViewModel {
    let uuid: String
    let name: String
    let startDate: String
    let totalCosts: [String]
}

// MARK: - Equatable
extension JourneysItemCellViewModel: Equatable { /*Nop*/ }

// MARK: - IdentifiableType
extension JourneysItemCellViewModel: IdentifiableType {
    var identity: String {
        uuid
    }
}
