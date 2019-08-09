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

    // swiftlint:disable force_cast force_unwrapping
    static var shared: AppDelegate { return UIApplication.shared.delegate as! AppDelegate }
    var root: RootViewController { return window!.rootViewController as! RootViewController }
    // swiftlint:enable force_cast force_unwrap

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions options: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        // MARK: Legacy
//        let rootViewController = TabBarController()
//        window?.rootViewController = rootViewController

        // MARK: New
        let rootController = RootViewController()
        window?.rootViewController = rootController

        setAppearances()

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

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary
        // interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition
        // to the background state. Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks.
        // Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to
        // restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state;
        // here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in
        // the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /* The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail. */
        let container = NSPersistentContainer(name: "Pokemon_Tabletop_Adventure")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping
                // application, although it may be useful during development.
                 
                /* Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was. */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }

            print("Store description: \(storeDescription)")
        }
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping
                // application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
