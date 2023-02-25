//
//  CurrencyButtonView.swift
//  CryptoBalance
//
//  Created by Serj on 21.02.2023.
//

import UIKit

// MARK: Custom CurrencyButton
class CurrencyButton: UIButton {
    
    var lable = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 12
        layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner ]
        backgroundColor = .systemGray4
        
        lable.text = "Select"
        lable.textAlignment = .center
        
        let iv = UIImageView(image: UIImage(systemName: "chevron.up.chevron.down"))
        iv.tintColor = .white
        
        
        let stack = UIStackView(arrangedSubviews: [lable, iv])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        
        stack.spacing = 4
        
        stack.isUserInteractionEnabled = false
        
        self.addSubview(stack)

        lable.widthAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true

        
        stack.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        stack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        self.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.widthAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
