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
        container.register(DatabaseManagerProtocol.self) { _ in
            let database = DatabaseManager()
            try! database.setup()
            return database
        }.inObjectScope(.container)

        container.register(JourneysRepositoryProtocol.self) { r in
            JourneysRepository(databaseManager: r.resolve(DatabaseManagerProtocol.self)!,
                               dateProvider: r.resolve(DateProviderProtocol.self)!)
        }

        container.register(DateProviderProtocol.self) { _ in
            DateProvider()
        }

        container.register(CompositionalLayoutFactoryProtocol.self) { _ in
            CompositionalLayoutFactory()
        }.inObjectScope(.container)
    }
}
