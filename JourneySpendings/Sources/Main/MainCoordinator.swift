//
//  MainCoordinator.swift
//  JourneySpendings
//
//  Created by Mariusz Sut on 08/08/2021.
//

import UIKit
import Swinject
import Core

enum MainTab {
    case journeys
    case about
    
    var tag: Int {
        switch self {
        case .journeys: return 0
        case .about: return 1
        }
    }
    
    var title: String {
        switch self {
        case .journeys: return "Journeys"
        case .about: return "About"
        }
    }
    
    var image: UIImage {
        switch self {
        case .journeys: return .add
        case .about: return .strokedCheckmark
        }
    }
}

final class MainCoordinator: Coordinator {
    private let tabBarController: UITabBarController
    let navigationController: UINavigationController
    let container: Container
    
    private lazy var journeysCoordinator: JourneysCoordinator = {
        JourneysCoordinator(navigationController: navigationController(tab: .journeys), container: container)
    }()
    
    private lazy var aboutCoordinator: AboutCoordinator = {
        AboutCoordinator(navigationController: navigationController(tab: .about), container: container)
    }()
    
    init(navigationController: UINavigationController, container: Container) {
        self.navigationController = navigationController
        self.container = container
        self.tabBarController = UITabBarController()
    }
    
    func start() {
        journeysCoordinator.start()
        aboutCoordinator.start()
        tabBarController.viewControllers = [journeysCoordinator.navigationController, aboutCoordinator.navigationController]
        navigationController.viewControllers = [tabBarController]
    }
    
    private func navigationController(tab: MainTab) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(title: tab.title, image: tab.image, tag: tab.tag)
        return navigationController
    }
}
