//
//  AboutCoordinator.swift
//  JourneySpendings
//
//  Created by Mariusz Sut on 08/08/2021.
//

import UIKit

final class AboutCoordinator: Coordinator {
    private lazy var aboutViewController = AboutViewController()
    let navigationController = UINavigationController()
    
    func start() {
        navigationController.viewControllers = [aboutViewController]
    }
}
