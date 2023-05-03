//
//  TabBarController.swift
//  CryptoBalance
//
//  Created by Serj on 14.02.2023.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        
        self.view.backgroundColor = .black // Обязательно если не указываем на других VC
//        self.tabBar.barTintColor = .black
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = #colorLiteral(red: 1, green: 0.8392156863, blue: 0.2666666667, alpha: 1)
        self.tabBar.backgroundColor = .black
        
        
        // MARK: FirstVC
        let exchangeVC = ExchangeVC()
        exchangeVC.tabBarItem.image = UIImage(systemName: "arrow.triangle.2.circlepath")
        exchangeVC.tabBarItem.title = "Exchange"
        let exchangeNAV = UINavigationController(rootViewController: exchangeVC)


        // MARK: ThirdVC
        let walletVC = WalletVC()
        walletVC.tabBarItem.image = UIImage(named: "WalletIcon")
        walletVC.tabBarItem.title = "Wallets"
        let walletNAV = UINavigationController(rootViewController: walletVC)

//        TestScrollView()
        let infoTVC = InfoTVC(style: .insetGrouped)
        infoTVC.tabBarItem.image = UIImage(systemName: "questionmark.circle")
        infoTVC.tabBarItem.title = "Info"
        let infoNAV = UINavigationController(rootViewController: infoTVC)
        
        
        self.viewControllers = [exchangeNAV, walletNAV, infoNAV]
        
    }
}

