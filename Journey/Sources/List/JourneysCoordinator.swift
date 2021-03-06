//
//  JourneysCoordinator.swift
//  Journey
//
//  Created by Mariusz Sut on 08/08/2021.
//

import UIKit
import Swinject
import Core

public protocol JourneysCoordinatorProtocol {
    func toCreateForm()
    func toDetails(journeyId: String)
}

final public class JourneysCoordinator: Coordinator {
    public let navigationController: UINavigationController
    public let container: Container

    public init(container: Container, navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.container = container
    }

    public func start() {
        let controller = container.resolve(JourneysViewController.self)!
        controller.viewModel.coordinator = self
        navigationController.viewControllers = [controller]
    }
}

// MARK: - JourneysCoordinatorProtocol
extension JourneysCoordinator: JourneysCoordinatorProtocol {
    public func toCreateForm() {
        let journeyCreateCoordinator = JourneyCreateCoordinator(container: container,
                                                                navigationController: navigationController)
        journeyCreateCoordinator.start()
    }

    public func toDetails(journeyId: String) {
        let journeyDetailsCoordinator = JourneyDetailsCoordinator(container: container,
                                                                  navigationController: navigationController,
                                                                  journeyId: journeyId)
        journeyDetailsCoordinator.start()
    }
}
