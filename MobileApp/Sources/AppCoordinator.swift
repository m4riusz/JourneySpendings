//
//  AppCoordinator.swift
//  JourneySpendings
//
//  Created by Mariusz Sut on 13/08/2021.
//

import UIKit
import Swinject
import Core

final class AppCoordinator: Coordinator {
    private let window: UIWindow
    let navigationController: UINavigationController
    let container: Container

    init(window: UIWindow, container: Container) {
        self.window = window
        self.navigationController = UINavigationController()
        self.container = container
    }

    func start() {
        navigationController.navigationBar.isHidden = true
        let mainCoordinator = MainCoordinator(navigationController: navigationController, container: container)
        mainCoordinator.start()
        window.rootViewController = mainCoordinator.navigationController
        window.makeKeyAndVisible()
    }
}
