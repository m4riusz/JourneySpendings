//
//  AboutAssembly.swift
//  JourneySpendings
//
//  Created by Mariusz Sut on 14/08/2021.
//

import Swinject

final class AboutAssembly: Assembly {
    func register(container: Container) {
        container.register(AboutViewModel.self) { r in
            AboutViewModel()
        }
        
        container.register(AboutViewController.self) { r in
            let controller = AboutViewController()
            controller.viewModel = r.resolve(AboutViewModel.self)!
            return controller
        }
    }
}
