//
//  JourneysCoordinator.swift
//  JourneySpendings
//
//  Created by Mariusz Sut on 08/08/2021.
//

import UIKit
import Swinject
import Core

protocol JourneysCoordinatorProtocol { /*Nop*/ }

final class JourneysCoordinator: Coordinator {
    let navigationController: UINavigationController
    let container: Container
    
    init(navigationController: UINavigationController, container: Container) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func start() {
        let controller = container.resolve(JourneysViewController.self)!
        controller.viewModel.coordinator = self
        navigationController.viewControllers = [controller]
    }
}

//MARK: - JourneysCoordinatorProtocol
extension JourneysCoordinator: JourneysCoordinatorProtocol { /*Nop*/ }
