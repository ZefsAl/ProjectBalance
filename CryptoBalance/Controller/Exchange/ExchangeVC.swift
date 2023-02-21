//
//  ExchangeVC.swift
//  CryptoBalance
//
//  Created by Serj on 17.02.2023.
//

import UIKit

class ExchangeVC: UIViewController {

    // SupportedCurrencies
    let tableSC = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavView()
        setupViews()
        setConstraints()

        
    }
    private func configureNavView() {
        view.backgroundColor = .orange
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        title = "Wallets"
        
        // MARK: Custom Add Button
        let addButtonView: UIView = {
            let lable = UILabel()
            lable.text = "Add "
            let image = UIImageView(image: UIImage(systemName: "plus"))
            image.tintColor = .white
            
            let stack = UIStackView(arrangedSubviews: [lable,image])
            stack.addSubview(lable)
            stack.addSubview(image)
            
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        // UIBarButtonItem - not work решил через - UITapGestureRecognizer
        let gesture = UITapGestureRecognizer(target: self, action: #selector(showModal))
        addButtonView.addGestureRecognizer(gesture)
        let barButtonItem = UIBarButtonItem(customView: addButtonView)
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    
    

    private func setupViews() {
//        view.addSubview(mainTableView)
    }

}

extension ExchangeVC {
    private func setConstraints() {
        //        let margin = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
