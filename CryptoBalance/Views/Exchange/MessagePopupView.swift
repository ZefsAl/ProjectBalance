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
    
    // MARK: init
    init(frame: CGRect, imageSystemName: String, imageColor: UIColor) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(named: "WhiteSoft")
        self.layer.cornerRadius = 12
        
        
        // MARK: Image
        let imageView: UIImageView = {
            let iv = UIImageView()
            iv.translatesAutoresizingMaskIntoConstraints = false
            iv.image = UIImage(systemName: imageSystemName)
            iv.tintColor = imageColor
            iv.contentMode = .center
            //            iv.backgroundColor = .brown
            iv.widthAnchor.constraint(equalToConstant: 24).isActive = true
            return iv
        }()
        
        // MARK: Lable
        
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = .systemGray6
        //        lable.font = .systemFont(ofSize: 17, weight: .medium)
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





extension MessagePopupView {
    func showMessagePopupView(showOnVC: UIViewController, message: String) {
        
        //        var messagePopupView = MessagePopupView(frame: .null, imageSystemName: imageSystemName, imageColor: imageColor)
        
        
        
        self.lable.attributedText = SupportResources().coloredStrind(string: message, color: .systemOrange)
        
        guard let navBar = showOnVC.navigationController?.navigationBar else { return }
        
        navBar.addSubview(self)
        
        
        
        // First position hiden
        let firstPosition = CGAffineTransform(translationX: 0.0, y: -(showOnVC.view.bounds.height + 0.2))
        self.transform = firstPosition
        
        // Show 
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            let moveToBottom = CGAffineTransform(translationX: 0.0, y: +(showOnVC.view.bounds.height * 0.0))
            self.transform = moveToBottom
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        } completion: { _ in
            
            // HIde
            Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { timer in
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                    let moveToTop = CGAffineTransform(translationX: 0.0, y: -(showOnVC.view.bounds.height * 0.2))
                    self.transform = moveToTop
                } completion: { _ in
                    self.removeFromSuperview()
                }
            }
            
        }
        
        
        
        
        //        // Show
        //        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
        //            let moveToBottom = CGAffineTransform(translationX: 0.0, y: +(showOnVC.view.bounds.height * 0.0))
        //            self.transform = moveToBottom
        //        } completion: { _ in
        //            let generator = UIImpactFeedbackGenerator(style: .light)
        //            generator.impactOccurred()
        //        }
        //
        //        // HIde
        //        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { timer in
        //            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
        //                let moveToTop = CGAffineTransform(translationX: 0.0, y: -(showOnVC.view.bounds.height * 0.2))
        //                self.transform = moveToTop
        //            } completion: { _ in
        //                self.removeFromSuperview()
        //            }
        //        }
        
        self.topAnchor.constraint(equalTo: navBar.topAnchor , constant: 8).isActive = true
        self.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 16).isActive = true
        self.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -16).isActive = true
        self.heightAnchor.constraint(greaterThanOrEqualToConstant: 80).isActive = true
        
        
        
    }
}





