//
//  CoreAssembly.swift
//  Core
//
//  Created by Mariusz Sut on 18/09/2021.
//

import Swinject

final public class CoreAssembly: ModuleAssembly {

    public init() { /*Nop*/ }

    public func register(container: Container) {
        container.register(DateProviderProtocol.self) { _ in
            DateProvider()
        }

        container.register(CompositionalLayoutFactoryProtocol.self) { _ in
            CompositionalLayoutFactory()
        }.inObjectScope(.container)
    }
}
