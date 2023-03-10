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
        self.contentMode = .scaleToFill
        
        layer.cornerRadius = 12
        layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner ]
        backgroundColor = .systemGray3
        
        lable.text = "Select"
        lable.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        lable.textAlignment = .center
        
        let configImage = UIImage(systemName: "chevron.up.chevron.down",
                                  withConfiguration: UIImage.SymbolConfiguration(pointSize: 17, weight: .semibold))
        let iv = UIImageView(image: configImage)
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        iv.tintColor = .white
        
        
        let stack = UIStackView(arrangedSubviews: [lable, iv])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        
        stack.spacing = 4
        
        stack.isUserInteractionEnabled = false
        
        self.addSubview(stack)


        
        
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


