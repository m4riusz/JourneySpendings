//
//  AboutCoordinator.swift
//  JourneySpendings
//
//  Created by Mariusz Sut on 08/08/2021.
//

import UIKit

final class AboutCoordinator: Coordinator {
    var rootViewController: UIViewController {
        UINavigationController(rootViewController: AboutViewController())
    }
    
    var childs: [Coordinator] = []
}
