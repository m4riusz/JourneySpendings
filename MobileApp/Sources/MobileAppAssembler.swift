//
//  MobileAppAssembler.swift
//  JourneySpendings
//
//  Created by Mariusz Sut on 14/08/2021.
//

import Swinject
import Core
import Journey
import About

final class MobileAppAssembler: AppAssembler {
    let container: Container

    var assemblies: [ModuleAssembly] = [
        JourneysAssembly(),
        AboutAssembly()
    ]

    init(container: Container, enviroment: [String: String]) {
        self.container = container
    }

    func assembly() {
        assemblies.forEach { $0.register(container: container) }
    }
}
