//
//  CustomLable14.swift
//  CryptoBalance
//
//  Created by Serj on 29.03.2023.
//

import UIKit

class CustomLable14: UILabel {
    
    var setColor: UIColor?
    var setText: String?

    
    init(frame: CGRect, setText: String?) {
        self.setText = setText
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        text = setText
        font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textColor = .white
        
        numberOfLines = 10
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
