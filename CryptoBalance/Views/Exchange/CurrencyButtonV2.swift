//
//  CurrencyButtonV.swift
//  CryptoBalance
//
//  Created by Serj on 06.03.2023.
//

import UIKit

class CurrencyButtonV2: UIButton {
    
    var lable = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .systemGray5
        layer.cornerRadius = 12
        
        lable.text = "Select"
        lable.textAlignment = .center
        lable.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        
        // Уменьшить font для lable.text?.count >= 10
        
//        lable.numberOfLines = 1;
//        lable.minimumScaleFactor = 0.5;
//        lable.adjustsFontSizeToFitWidth = true
        
        
        
//        if let lableCount = lable.text?.count{
//            if lableCount >= 7 {
//                lable.font = UIFont.systemFont(ofSize: 12, weight: .black)
//                lable.textColor = .systemOrange
//            } else {
//                lable.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
//                lable.textColor = .red
//            }
//        }
        
        
        
        
        let configure = UIImage.SymbolConfiguration(pointSize: 17, weight: .semibold)
        let configImage = UIImage(systemName: "chevron.up.chevron.down", withConfiguration: configure)
        let iv = UIImageView(image: configImage)
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        iv.tintColor = .white
        
        let stack = UIStackView(arrangedSubviews: [lable, iv])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.spacing = 4
        stack.isUserInteractionEnabled = false
        self.addSubview(stack)
        
        lable.widthAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true

        
        stack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        self.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
//        lable.widthAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
//        stack.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
//        stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
//        stack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12).isActive = true
//        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
//        self.widthAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
