//
//  AppDelegate.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merryweather on 09/05/2018.
//  Copyright © 2018 Undersea Love. All rights reserved.
//

import CoreData
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // swiftlint:disable:next force_cast
    static var shared: AppDelegate { return UIApplication.shared.delegate as! AppDelegate }

    var rootCoordinator: RootCoordinator?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions options: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        
        rootCoordinator = RootCoordinator(router: navigationController)
        setAppearances()

        rootCoordinator?.start()
        return true
    }

    func setAppearances() {
        let rootViewController = [RootViewController.self]
        var attributes: [NSAttributedString.Key: Any] = [.font: UIFont.italicSystemFont(ofSize: 12)]
        UIView.appearance(whenContainedInInstancesOf: rootViewController).tintColor = .logo
        let allBarButtonItems = UIBarButtonItem.appearance(whenContainedInInstancesOf: rootViewController)
        allBarButtonItems.setTitleTextAttributes(attributes, for: .normal)
        allBarButtonItems.setTitleTextAttributes(attributes, for: .selected)
        allBarButtonItems.setTitleTextAttributes(attributes, for: .highlighted)
        let allNavigationBars = UINavigationBar.appearance(whenContainedInInstancesOf: rootViewController)
        allNavigationBars.prefersLargeTitles = true
        attributes = [.foregroundColor: UIColor.body]
        allNavigationBars.titleTextAttributes = attributes
        allNavigationBars.largeTitleTextAttributes = attributes
    }
}
