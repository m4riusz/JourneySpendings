//
//  MainCoordinator.swift
//  JourneySpendings
//
//  Created by Mariusz Sut on 08/08/2021.
//

import UIKit
import Swinject
import Core
import Journey
import About

final class MainCoordinator: Coordinator {
    private let tabBarController: UITabBarController
    let navigationController: UINavigationController
    let container: Container

    private lazy var journeysCoordinator: JourneysCoordinator = {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(title: Assets.Strings.MobileApp.journeyTab,
                                                       image: Assets.Images.MobileApp.cardTravel,
                                                       tag: 0)
        return JourneysCoordinator(container: container, navigationController: navigationController)
    }()

    private lazy var aboutCoordinator: AboutCoordinator = {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = .init(title: Assets.Strings.MobileApp.aboutTab,
                                                image: Assets.Images.MobileApp.infoOutline,
                                                tag: 1)
        return AboutCoordinator(container: container, navigationController: navigationController)
    }()

    init(navigationController: UINavigationController, container: Container) {
        self.navigationController = navigationController
        self.container = container
        self.tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = Assets.Colors.Core.Action.primary
    }

    func start() {
        journeysCoordinator.start()
        aboutCoordinator.start()
        tabBarController.viewControllers = [journeysCoordinator.navigationController, aboutCoordinator.navigationController]
        navigationController.viewControllers = [tabBarController]
    }
}
