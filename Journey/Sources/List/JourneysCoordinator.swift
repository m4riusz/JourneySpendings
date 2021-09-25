//
//  JourneysCoordinator.swift
//  Journey
//
//  Created by Mariusz Sut on 08/08/2021.
//

import UIKit
import Swinject
import Core

public protocol JourneysCoordinatorProtocol { /*Nop*/ }

final public class JourneysCoordinator: Coordinator {
    public let navigationController: UINavigationController
    public let container: Container

    public init(container: Container) {
        navigationController = UINavigationController()
        self.container = container
    }

    public func start() {
        let controller = container.resolve(JourneysViewController.self)!
        controller.viewModel.coordinator = self
        navigationController.viewControllers = [controller]
    }
}

// MARK: - JourneysCoordinatorProtocol
extension JourneysCoordinator: JourneysCoordinatorProtocol { /*Nop*/ }
