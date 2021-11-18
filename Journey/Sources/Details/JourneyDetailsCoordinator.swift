//
//  JourneyDetailsCoordinator.swift
//  Journey
//
//  Created by Mariusz Sut on 16/11/2021.
//

import UIKit
import Core
import Swinject

protocol JourneyDetailsCoordinatorProtocol {
    func didFinish()
}

final class JourneyDetailsCoordinator: Coordinator {
    let navigationController: UINavigationController
    let container: Container
    let journeyId: String

    public init(container: Container, navigationController: UINavigationController, journeyId: String) {
        self.navigationController = navigationController
        self.container = container
        self.journeyId = journeyId
    }

    func start() {
        let controller = container.resolve(JourneyDetailsViewController.self, argument: journeyId)!
        controller.viewModel.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }
}

// MARK: - JourneyDetailsCoordinatorProtocol
extension JourneyDetailsCoordinator: JourneyDetailsCoordinatorProtocol {
    func didFinish() {
        navigationController.popViewController(animated: true)
    }
}
