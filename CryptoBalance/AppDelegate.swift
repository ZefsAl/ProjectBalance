//
//  AppDelegate.swift
//  CryptoBalance
//
//  Created by Serj on 31.12.2022.
//

import UIKit
import IQKeyboardManager

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        IQKeyboardManager.shared().toolbarDoneBarButtonItemText = "Done"
        IQKeyboardManager.shared().toolbarTintColor = .white
        
        IQKeyboardManager.shared().shouldShowToolbarPlaceholder = false
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

