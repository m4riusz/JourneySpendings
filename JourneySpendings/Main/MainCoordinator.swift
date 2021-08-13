//
//  MainCoordinator.swift
//  JourneySpendings
//
//  Created by Mariusz Sut on 08/08/2021.
//

import UIKit
import Swinject

final class MainCoordinator: Coordinator {
    private let window: UIWindow
    private var controller: MainViewController!
    let navigationController: UINavigationController
    let container: Container
    
    init(window: UIWindow, navigationController: UINavigationController, container: Container) {
        self.window = window
        self.navigationController = navigationController
        self.container = container
    }
    
    func start() {
        let journeysCoordinator = JourneysCoordinator(container: container)
        journeysCoordinator.start()
        let aboutCoordinator = AboutCoordinator(container: container)
        aboutCoordinator.start()
        controller = container.resolve(MainViewController.self)!
        controller.viewModel.coordinator = self
        controller.viewControllers = [journeysCoordinator.navigationController, aboutCoordinator.navigationController]
        navigationController.viewControllers = [controller]
        navigationController.navigationBar.isHidden = true
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func showJourneysTab() {
        controller.selectTab(tag: 0)
    }
    
    func showAboutTab() {
        controller.selectTab(tag: 1)
    }
}
