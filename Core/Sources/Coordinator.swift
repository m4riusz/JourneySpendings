//
//  Coordinator.swift
//  Core
//
//  Created by Mariusz Sut on 08/08/2021.
//

import UIKit
import Swinject

public protocol Coordinator {
    var navigationController: UINavigationController { get }
    var container: Container { get }
    
    func start()
}
