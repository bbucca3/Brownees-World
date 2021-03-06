//
//  AppDelegate.swift
//  Brownee's World
//
//  Created by Benjamin Bucca on 7/20/16.
//  Copyright © 2016 Benjamin Bucca. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Set tabBar to be root view
        let tabBar: UITabBarController = self.window?.rootViewController as! UITabBarController
        // Set selectedIndex to be first tab
        tabBar.selectedIndex = 0
        // Check if app is first time launching ever
        _ = isAppAlreadyLaunchedOnce()
        return true
    }
    
    func isAppAlreadyLaunchedOnce() -> Bool {
        // Create defaults
        let defaults = UserDefaults.standard
        // Check point for app previous launch
        if let isAppAlreadyLaunchedOnce = defaults.string(forKey: "isAppAlreadyLaunchedOnce"){
            print("App already launched : \(isAppAlreadyLaunchedOnce)")
            return true
        } else {
            // Set key value pair for successful app launch
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            // Set window to device dimensions
            self.window = UIWindow(frame: UIScreen.main.bounds)
            // Ref to storyboard where view controller is
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            // Ref to view controller to show first
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "OnboardViewController")
            // Sets that view controller as the root
            self.window?.rootViewController = initialViewController
            // Sets window to be visible
            self.window?.makeKeyAndVisible()
            return true
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

