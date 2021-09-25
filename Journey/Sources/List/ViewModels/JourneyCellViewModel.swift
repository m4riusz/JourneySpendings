//
//  JourneyCellViewModel.swift
//  Journey
//
//  Created by Mariusz Sut on 25/09/2021.
//

import Core
import UIKit

struct JourneysItemCellViewModel {

}

extension JourneysItemCellViewModel: CellConfiguratorProtocol {
    var cellConfigurator: CellRepresentable {
        CellConfigurator<JourneyItemCell, JourneysItemCellViewModel>(item: self)
    }
}
