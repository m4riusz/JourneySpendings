//
//  JourneysCoordinator.swift
//  JourneySpendings
//
//  Created by Mariusz Sut on 08/08/2021.
//

import UIKit

final class JourneysCoordinator: Coordinator {
    private lazy var journeysViewController = JourneysViewController()
    let navigationController = UINavigationController()
    
    func start() {
        navigationController.viewControllers = [journeysViewController]
    }
}
