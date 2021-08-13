//
//  AppDelegate.swift
//  JourneySpendings
//
//  Created by Mariusz Sut on 08/08/2021.
//

import UIKit
import Swinject

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    private lazy var container = Container()
    private var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupContainer(container: container)
        appCoordinator = AppCoordinator(window: UIWindow(frame: UIScreen.main.bounds),
                                        navigationController: UINavigationController(),
                                        container: container)
        appCoordinator?.start()
        return true
    }
    
    func setupContainer(container: Container) {
        // Main
        container.register(MainViewModel.self) { r in
            MainViewModel()
        }
        
        container.register(MainViewController.self) { r in
            let controller = MainViewController()
            controller.viewModel = r.resolve(MainViewModel.self)!
            return controller
        }
        
        // About
        container.register(AboutViewModel.self) { r in
            AboutViewModel()
        }
        
        container.register(AboutViewController.self) { r in
            let controller = AboutViewController()
            controller.viewModel = r.resolve(AboutViewModel.self)!
            return controller
        }
        
        // Journeys
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
