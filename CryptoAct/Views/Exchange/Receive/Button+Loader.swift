//
//  Button+Loader.swift
//  CryptoBalance
//
//  Created by Serj on 05.04.2023.
//

import UIKit

class Button_Loader: UIButton {

    
    
    let lable = UILabel()
    let activityIndicator = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        // Button
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 12
        backgroundColor = UIColor(named: "PrimaryColor")
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // lable
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.isUserInteractionEnabled = false
        lable.textColor = .black
        lable.text = "Confirm"
        lable.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        // Activity Indicator
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.heightAnchor.constraint(equalToConstant: 40).isActive = true
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .black
        
        let contentStack = UIStackView(arrangedSubviews: [lable,activityIndicator])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.spacing = 8
        contentStack.axis = .horizontal
        
        self.addSubview(contentStack)
        contentStack.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        contentStack.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
