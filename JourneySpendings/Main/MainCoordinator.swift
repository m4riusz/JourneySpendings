//
//  MainCoordinator.swift
//  JourneySpendings
//
//  Created by Mariusz Sut on 08/08/2021.
//

import UIKit
import Swinject

protocol MainCoordinatorProtocol {
    func showJourneysTab()
    func showAboutTab()
}

final class MainCoordinator: Coordinator {
    private var controller: MainViewController!
    let navigationController: UINavigationController
    let container: Container
    
    private lazy var journeysCoordinator: JourneysCoordinator = {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(title: "Journeys", image: nil, tag: MainTab.journeys.rawValue)
        let coordinator = JourneysCoordinator(navigationController: navigationController, container: container)
        return coordinator
    }()
    
    private lazy var aboutCoordinator: AboutCoordinator = {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(title: "About", image: nil, tag: MainTab.about.rawValue)
        let coordinator = AboutCoordinator(navigationController: navigationController, container: container)
        return coordinator
    }()
    
    init(navigationController: UINavigationController, container: Container) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func start() {
        controller = container.resolve(MainViewController.self)!
        controller.viewModel.coordinator = self
        journeysCoordinator.start()
        aboutCoordinator.start()
        controller.viewControllers = [journeysCoordinator.navigationController, aboutCoordinator.navigationController]
        navigationController.viewControllers = [controller]
    }
}

//MARK: - MainCoordinatorProtocol
extension MainCoordinator: MainCoordinatorProtocol {
    func showJourneysTab() {
        controller.selectTab(tag: MainTab.journeys.rawValue)
    }
    
    func showAboutTab() {
        controller.selectTab(tag: MainTab.about.rawValue)
    }
}
