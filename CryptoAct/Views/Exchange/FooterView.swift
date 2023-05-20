//
//  FooterView.swift
//  CryptoBalance
//
//  Created by Serj on 15.04.2023.
//

import UIKit

class FooterView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = "no transactions"
        lable.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        lable.textColor = .systemGray5
        
        
        self.frame = CGRectMake(0, 0, 0, 50)
        self.addSubview(lable)
        
        // Constraints
        lable.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        lable.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
