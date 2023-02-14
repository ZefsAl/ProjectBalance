//
//  AppDelegate.swift
//  CryptoBalance
//
//  Created by Serj on 31.12.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window?.overrideUserInterfaceStyle = .dark
        window = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController(rootViewController: MainViewController())
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

