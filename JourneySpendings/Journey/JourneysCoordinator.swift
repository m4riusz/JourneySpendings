//
//  JourneysCoordinator.swift
//  JourneySpendings
//
//  Created by Mariusz Sut on 08/08/2021.
//

import UIKit

final class JourneysCoordinator: Coordinator {
    var rootViewController: UIViewController {
        UINavigationController(rootViewController: JourneysViewController())
    }
    
    var childs: [Coordinator] = []
}
