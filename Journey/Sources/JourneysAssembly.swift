//
//  JourneysAssembly.swift
//  Journey
//
//  Created by Mariusz Sut on 14/08/2021.
//

import Swinject
import Core

final public class JourneysAssembly: ModuleAssembly {
    
    public init() { /*Nop*/ }
    
    public func register(container: Container) {
        container.register(JourneysViewModel.self) { r in
            JourneysViewModel()
        }
        
        container.register(JourneysViewController.self) { r in
            let controller = JourneysViewController()
            controller.viewModel = r.resolve(JourneysViewModel.self)!
            return controller
        }
    }
}
