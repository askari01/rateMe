//
//  AppDelegate.swift
//  RateMe
//
//  Created by Syed Askari on 29/01/2018.
//  Copyright © 2018 Syed Askari. All rights reserved.
//

import UIKit
import Sentry
import Firebase
import FirebaseDatabase
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Create a Sentry client and start crash handler
        do {
            Client.shared = try Client(dsn: "https://5d6fdf3ef0c749a7974bb3350c1340d3:4d4a4ee134fc4b81be558579ec101b50@sentry.io/282177")
            try Client.shared?.startCrashHandler()
        } catch let error {
            print("\(error)")
            // Wrong DSN or KSCrash not installed
        }
        
        // firebase
        FirebaseApp.configure()
        // keyboard
        IQKeyboardManager.sharedManager().enable = true
        // firebase offline data storage
        Database.database().isPersistenceEnabled = true
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}
