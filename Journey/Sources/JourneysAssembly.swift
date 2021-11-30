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
            JourneysViewModel(repository: r.resolve(JourneysRepositoryProtocol.self)!)
        }

        container.register(JourneysViewController.self) { r in
            let controller = JourneysViewController()
            controller.viewModel = r.resolve(JourneysViewModel.self)!
            controller.layoutFactory = r.resolve(CompositionalLayoutFactoryProtocol.self)!
            return controller
        }

        container.register(JourneyValidatorProviderProtocol.self) { _ in
            JourneyValidatorProvider()
        }

        container.register(JourneyCreateViewModel.self) { r in
            JourneyCreateViewModel(repository: r.resolve(JourneysRepositoryProtocol.self)!,
                                   validatorProvider: r.resolve(JourneyValidatorProviderProtocol.self)!)
        }

        container.register(JourneyCreateViewController.self) { r in
            let controller = JourneyCreateViewController()
            controller.viewModel = r.resolve(JourneyCreateViewModel.self)!
            controller.layoutFactory = r.resolve(CompositionalLayoutFactoryProtocol.self)!
            return controller
        }

        container.register(JourneyDetailsViewModel.self) { r, journeyId in
            JourneyDetailsViewModel(journeyId: journeyId,
                                    repository: r.resolve(JourneysRepositoryProtocol.self)!)
        }

        container.register(JourneyDetailsViewController.self) { (r: Resolver, journeyId: String) in
            let controller = JourneyDetailsViewController()
            controller.viewModel = r.resolve(JourneyDetailsViewModel.self, argument: journeyId)!
            controller.layoutFactory = r.resolve(CompositionalLayoutFactoryProtocol.self)!
            return controller
        }
    }
}
