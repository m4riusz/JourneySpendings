//
//  Coordinator.swift
//  JourneySpendings
//
//  Created by Mariusz Sut on 08/08/2021.
//

import UIKit

public protocol Coordinator {
    var navigationController: UINavigationController { get }
    
    func start()
}
