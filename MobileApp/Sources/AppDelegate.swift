//
//  AppDelegate.swift
//  JourneySpendings
//
//  Created by Mariusz Sut on 08/08/2021.
//

import UIKit
import Core
import Swinject

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    private lazy var assembler = MobileAppAssembler(container: Container(), enviroment: ProcessInfo().environment)
    private var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        assembler.assembly()
        appCoordinator = AppCoordinator(window: UIWindow(frame: UIScreen.main.bounds),
                                        navigationController: UINavigationController(),
                                        container: assembler.container)
        try! FontLoader().load()
        appCoordinator?.start()
        return true
    }
}
