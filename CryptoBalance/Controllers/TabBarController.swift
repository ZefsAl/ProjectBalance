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

        let vc2: UIViewController = {
           let vc = UIViewController()
            vc.view.backgroundColor = .green
            vc.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 1)
            return vc
        }()
        
        self.tabBar.tintColor = #colorLiteral(red: 1, green: 0.8392156863, blue: 0.2666666667, alpha: 1)
        
        let firstVC = UINavigationController(rootViewController: ExchangeVC())
        let firstImage = UIImage(systemName: "creditcard.fill")
        firstVC.tabBarItem = UITabBarItem(title: "Exchange", image: firstImage, tag: 0)
        
        
        let thirdVC = UINavigationController(rootViewController: WalletVC())
        let thirdImage = UIImage(named: "WalletIcon")
        thirdVC.tabBarItem = UITabBarItem(title: "Wallet", image: thirdImage, selectedImage: nil)
        
        
        let secondVC = UINavigationController(rootViewController: vc2)
        secondVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
        
        // Прописать каждому свой навигейшн контроллер
        viewControllers = [firstVC,secondVC,thirdVC]
    }
}
