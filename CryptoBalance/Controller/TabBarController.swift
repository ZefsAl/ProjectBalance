//
//  TabBarController.swift
//  CryptoBalance
//
//  Created by Serj on 14.02.2023.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
//        view.backgroundColor = .systemGroupedBackground
//        view.backgroundColor = .orange
        self.tabBar.backgroundColor = .quaternarySystemFill
        let vc1: UIViewController = {
           let vc = UIViewController()
            vc.view.backgroundColor = .purple
            vc.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 0)
            return vc
        }()
        let vc2: UIViewController = {
           let vc = UIViewController()
            vc.view.backgroundColor = .green
            vc.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 1)
            return vc
        }()
        
//        tabBarItem =
        let thirdVC = UINavigationController(rootViewController: MainViewController())
        thirdVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 2)
        // Прописать каждому свой навигейшн контроллер
        viewControllers = [vc1,vc2,thirdVC]
    }
}
