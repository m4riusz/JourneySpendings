//
//  JourneysCoordinator.swift
//  JourneySpendings
//
//  Created by Mariusz Sut on 08/08/2021.
//

import UIKit
import Swinject

final class JourneysCoordinator: Coordinator {
    let navigationController = UINavigationController()
    let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    func start() {
        let controller = container.resolve(JourneysViewController.self)!
        controller.viewModel.coordinator = self
        navigationController.viewControllers = [controller]
        navigationController.tabBarItem = UITabBarItem(title: "Journeys", image: nil, tag: 0)
    }
}
