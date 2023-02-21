//
//  CurrencyButtonView.swift
//  CryptoBalance
//
//  Created by Serj on 21.02.2023.
//

import UIKit

// MARK: CurrencyButton
class CurrencyButton: UIButton {
    
    var lable = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        lable.text = "Select"
        
        let iv = UIImageView(image: UIImage(systemName: "chevron.up.chevron.down"))
        iv.tintColor = .white
        
        let stack = UIStackView(arrangedSubviews: [lable, iv])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.spacing = 4
        
        
        
//        self.insertSubview(stack, belowSubview: self)
        self.addSubview(stack)
        stack.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        
        stack.isUserInteractionEnabled = false
        
        
        layer.cornerRadius = 12
        backgroundColor = .systemGray5
        
        heightAnchor.constraint(equalToConstant: 60).isActive = true
        widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
