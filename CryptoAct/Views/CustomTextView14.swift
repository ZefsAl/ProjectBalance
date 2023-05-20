//
//  CustomLable14.swift
//  CryptoBalance
//
//  Created by Serj on 29.03.2023.
//

import UIKit

class CustomTextView14: UITextView {
    
    var setColor: UIColor?
    var setText: String?
    
//    init
    
    init(frame: CGRect, textContainer: NSTextContainer?, setColor: UIColor, setText: String?) {
        
        self.setColor = setColor
        self.setText = setText
        
        super.init(frame: frame, textContainer: textContainer)
        
//        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false
        text = setText
        font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textColor = setColor
        textAlignment = .left
        contentInsetAdjustmentBehavior = .never
        
        backgroundColor = .yellow
        
        self.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
        
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
