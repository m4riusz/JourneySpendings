//
//  JourneyCreateCoordinator.swift
//  Journey
//
//  Created by Mariusz Sut on 19/10/2021.
//

import UIKit
import Core
import Swinject

protocol JourneyCreateCoordinatorProtocol {
    func didFinish()
}

final class JourneyCreateCoordinator: Coordinator {
    let navigationController: UINavigationController
    let container: Container

    public init(container: Container, navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.container = container
    }

    func start() {
        let controller = container.resolve(JourneyCreateViewController.self)!
        controller.viewModel.coordinator = self
        controller.modalPresentationStyle = .automatic
        navigationController.present(UINavigationController(rootViewController: controller), animated: true)
    }
}

// MARK: - JourneyCreateCoordinatorProtocol
extension JourneyCreateCoordinator: JourneyCreateCoordinatorProtocol {
    func didFinish() {
        navigationController.presentedViewController?.dismiss(animated: true)
    }
}
