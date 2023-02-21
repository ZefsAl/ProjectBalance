//
//  ExchangeVC.swift
//  CryptoBalance
//
//  Created by Serj on 17.02.2023.
//

import UIKit




class ExchangeVC: UIViewController, TableSCDelegate {
    
    func getTableValue(network: String) {
        networkLable.text = network
        currencyButton.lable.text = network
        print(network)
    }
    
    

    // SupportedCurrencies
    let supportedCurrencyTableVC = SupportedCurrencyTableVC()
    
//    let customButtonView = CurrencyButtonView()
    
    
    
    
    
    let currencyButton: CurrencyButton = {
       let b = CurrencyButton()
        b.addTarget(Any.self, action: #selector(btnPressed), for: .touchUpInside)
        return b
    }()

    
    let networkLable: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "TEST"
        
        return l
    }()
    
    
    @objc func btnPressed() {
        let modalNav = UINavigationController(rootViewController: supportedCurrencyTableVC)
        self.navigationController?.show(modalNav, sender: AnyObject.self)
    }
    
    
// MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavView()
        setupViews()
        setConstraints()
        
        
        // delegate
        supportedCurrencyTableVC.tableSCDelegate = self
        
        
                
    }
    
    private func configureNavView() {
        view.backgroundColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        title = "Exchange"
        
    }
    
    private func setupViews() {
        view.addSubview(networkLable)
        view.addSubview(currencyButton)
    }
    
    

}

// MARK: Constraints
extension ExchangeVC {
    private func setConstraints() {
        let margin = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            
            currencyButton.centerYAnchor.constraint(equalTo: margin.centerYAnchor),
            currencyButton.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            
            networkLable.centerYAnchor.constraint(equalTo: margin.centerYAnchor),
            networkLable.trailingAnchor.constraint(equalTo: margin.trailingAnchor),


        ])
    }
}
