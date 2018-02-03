//
//  AppDelegate.swift
//  RateMe
//
//  Created by Syed Askari on 29/01/2018.
//  Copyright © 2018 Syed Askari. All rights reserved.
//

import Firebase
import FirebaseDatabase
import IQKeyboardManagerSwift
import Sentry
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        let value = UIInterfaceOrientation.landscapeLeft.rawValue
//        UIDevice.current.setValue(value, forKey: "orientation")
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

    func applicationWillResignActive(_: UIApplication) {
    }

    func applicationDidEnterBackground(_: UIApplication) {
    }

    func applicationWillEnterForeground(_: UIApplication) {
    }

    func applicationDidBecomeActive(_: UIApplication) {
    }

    func applicationWillTerminate(_: UIApplication) {
    }
}
