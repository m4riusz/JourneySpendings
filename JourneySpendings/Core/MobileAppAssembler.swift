//
//  MobileAppAssembler.swift
//  JourneySpendings
//
//  Created by Mariusz Sut on 14/08/2021.
//

import Swinject

final class MobileAppAssembler: Assembler {
    let container: Container
    
    var assemblies: [Assembly] = [
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
