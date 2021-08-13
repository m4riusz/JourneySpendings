//
//  AboutCoordinator.swift
//  JourneySpendings
//
//  Created by Mariusz Sut on 08/08/2021.
//

import UIKit
import Swinject

final class AboutCoordinator: Coordinator {
    let navigationController = UINavigationController()
    let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    func start() {
        let controller = container.resolve(AboutViewController.self)!
        controller.viewModel.coordinator = self
        navigationController.viewControllers = [controller]
        navigationController.tabBarItem = UITabBarItem(title: "About", image: nil, tag: 1)
    }
}
