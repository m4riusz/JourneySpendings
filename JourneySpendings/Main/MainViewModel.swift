//
//  MainViewModel.swift
//  JourneySpendings
//
//  Created by Mariusz Sut on 13/08/2021.
//

import Foundation

enum MainTab: Int {
    case journeys
    case about
}

final class MainViewModel {
    var coordinator: MainCoordinator!
    
    func selectTab(index: Int) {
        guard let tab = MainTab(rawValue: index) else { return }
        switch tab {
        case .journeys:
            coordinator.showJourneysTab()
        case .about:
            coordinator.showAboutTab()
        }
    }
}
