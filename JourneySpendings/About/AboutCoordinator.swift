//
//  AboutCoordinator.swift
//  JourneySpendings
//
//  Created by Mariusz Sut on 08/08/2021.
//

import UIKit
import Swinject

protocol AboutCoordinatorProtocol { /*Nop*/ }

final class AboutCoordinator: Coordinator {
    let navigationController: UINavigationController
    let container: Container
    
    init(navigationController: UINavigationController, container: Container) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func start() {
        let controller = container.resolve(AboutViewController.self)!
        controller.viewModel.coordinator = self
        navigationController.viewControllers = [controller]
    }
}

//MARK: - AboutCoordinatorProtocol
extension AboutCoordinator: AboutCoordinatorProtocol { /*Nop*/ }
