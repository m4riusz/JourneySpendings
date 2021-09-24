//
//  AboutCoordinator.swift
//  About
//
//  Created by Mariusz Sut on 08/08/2021.
//

import UIKit
import Swinject
import Core

public protocol AboutCoordinatorProtocol { /*Nop*/ }

final public class AboutCoordinator: Coordinator {
    public let navigationController: UINavigationController
    public let container: Container

    public init(container: Container) {
        navigationController = UINavigationController()
        self.container = container
    }

    public func start() {
        let controller = container.resolve(AboutViewController.self)!
        controller.viewModel.coordinator = self
        navigationController.viewControllers = [controller]
    }
}

// MARK: - AboutCoordinatorProtocol
extension AboutCoordinator: AboutCoordinatorProtocol { /*Nop*/ }
