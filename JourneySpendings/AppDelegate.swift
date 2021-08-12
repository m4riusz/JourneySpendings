//
//  AppDelegate.swift
//  JourneySpendings
//
//  Created by Mariusz Sut on 08/08/2021.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    private var mainCoordinator: MainCoordinator?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        mainCoordinator = MainCoordinator(window: UIWindow(frame: UIScreen.main.bounds))
        mainCoordinator?.start()
        return true
    }
}
