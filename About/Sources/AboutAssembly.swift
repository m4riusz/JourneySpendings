//
//  AboutAssembly.swift
//  About
//
//  Created by Mariusz Sut on 14/08/2021.
//

import Swinject
import Core

final public class AboutAssembly: ModuleAssembly {

    public init() { /*Nop*/ }

    public func register(container: Container) {
        container.register(AboutViewModel.self) { _ in
            AboutViewModel()
        }

        container.register(AboutViewController.self) { r in
            let controller = AboutViewController()
            controller.viewModel = r.resolve(AboutViewModel.self)!
            return controller
        }
    }
}
