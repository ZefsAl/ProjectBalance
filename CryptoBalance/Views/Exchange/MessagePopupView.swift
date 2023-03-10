//
//  MessagePopupView.swift
//  CryptoBalance
//
//  Created by Serj on 04.03.2023.
//

import Foundation
import UIKit

class MessagePopupView: UIView {
    
    let lable = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(named: "WhiteSoft")
        self.layer.cornerRadius = 12
        
        
// MARK: Image
        let imageView: UIImageView = {
           let iv = UIImageView()
            iv.translatesAutoresizingMaskIntoConstraints = false
            iv.image = UIImage(systemName: "exclamationmark.triangle")
            iv.tintColor = .systemOrange
            iv.contentMode = .center
//            iv.backgroundColor = .brown
            iv.widthAnchor.constraint(equalToConstant: 24).isActive = true
            return iv
        }()
        
// MARK: Lable
        
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = .systemGray6
//        lable.font = .systemFont(ofSize: 17, weight: .medium)
//            l.lineBreakMode = .byWordWrapping
        lable.sizeToFit()
        lable.numberOfLines = 0
        lable.textAlignment = .left
        
        
        // MARK: Stack
        let imageLableStack = UIStackView(arrangedSubviews: [imageView,lable])
        imageLableStack.translatesAutoresizingMaskIntoConstraints = false
        imageLableStack.axis = .horizontal
        imageLableStack.alignment = .fill
        imageLableStack.spacing = 8
        
        addSubview(imageLableStack)
        
        NSLayoutConstraint.activate([
            
            imageLableStack.topAnchor.constraint(equalTo: topAnchor),
            imageLableStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            imageLableStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            imageLableStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}











