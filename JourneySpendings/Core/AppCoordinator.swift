//
//  AppCoordinator.swift
//  JourneySpendings
//
//  Created by Mariusz Sut on 13/08/2021.
//

import UIKit
import Swinject

final class AppCoordinator: Coordinator {
    private let window: UIWindow
    let navigationController: UINavigationController
    let container: Container
    
    init(window: UIWindow, navigationController: UINavigationController, container: Container) {
        self.window = window
        self.navigationController = navigationController
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
