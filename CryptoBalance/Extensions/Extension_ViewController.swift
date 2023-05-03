//
//  File.swift
//  CryptoBalance
//
//  Created by Serj on 29.03.2023.
//

import Foundation
import UIKit




extension UIViewController {
    
    
    
    // MARK: set Dismiss Nav Item
    public func setDismissNavButtonItem(selectorStr: Selector) {
        
        let dismissButton: UIView = {
            
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            
            let configImage = UIImage(systemName: "xmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 28, weight: .regular))
            
            let iv = UIImageView(image: configImage)
            iv.translatesAutoresizingMaskIntoConstraints = false
            iv.tintColor = .systemGray3
            iv.backgroundColor = .lightGray
            iv.layer.cornerRadius = 30
            iv.isUserInteractionEnabled = false
            
            v.addSubview(iv)
            
            v.heightAnchor.constraint(equalToConstant: 32).isActive = true
            v.widthAnchor.constraint(equalToConstant: 32).isActive = true
            
            return v
        }()
        
        // Add Nav Item
        let dismissButtonItem = UIBarButtonItem(customView: dismissButton)
        //        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissButtonAction))
        let gesture = UITapGestureRecognizer(target: self, action: selectorStr)
        dismissButton.addGestureRecognizer(gesture)
        self.navigationItem.rightBarButtonItem = dismissButtonItem
        
    }
    
    
    
    
    // MARK: Action dissmiss
    @objc func dismissButtonAction() {
        self.dismiss(animated: true)
        print("dismissButtonAction")
    }
    // MARK: Action popToRoot
    @objc func popToRootButtonAction() {
        self.navigationController?.popToRootViewController(animated: true)
        
        print("popToRootButtonAction")
    }
    
    
    
    
    // MARK: Regular Custom Annotation
    func showRegularCustomAnnotation(message: String, imageSystemName: String, imageColor: UIColor) {
        
        let messagePopupView = MessagePopupView(frame: .null, imageSystemName: imageSystemName, imageColor: imageColor)
        
        messagePopupView.lable.attributedText = SupportResources().coloredStrind(string: message, color: .systemOrange)
        
        guard let navBar = self.navigationController?.navigationBar else { return }
        navBar.addSubview(messagePopupView)
        
        // First position hiden
        let firstPosition = CGAffineTransform(translationX: 0.0, y: -(self.view.bounds.height + 1.0))
        messagePopupView.transform = firstPosition
        
        // Show
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) { [self] in
            let moveToBottom = CGAffineTransform(translationX: 0.0, y: +(self.view.bounds.height * 0.0))
            messagePopupView.transform = moveToBottom
        } completion: { _ in
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
        
        // HIde
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { timer in
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                let moveToTop = CGAffineTransform(translationX: 0.0, y: -(self.view.bounds.height * 0.9))
                messagePopupView.transform = moveToTop
            } completion: { _ in
                messagePopupView.removeFromSuperview()
            }
        }
        
        messagePopupView.topAnchor.constraint(equalTo: navBar.topAnchor , constant: 8).isActive = true
        messagePopupView.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 16).isActive = true
        messagePopupView.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -16).isActive = true
        messagePopupView.heightAnchor.constraint(greaterThanOrEqualToConstant: 80).isActive = true
        
    }
    
    // MARK: Small Custom Annotation
    func showSmallCustomAnnotation(message: String, imageSystemName: String, imageColor: UIColor) {
        
        let messagePopupView = MessagePopupView(frame: .null, imageSystemName: imageSystemName, imageColor: imageColor)
        
        messagePopupView.lable.attributedText = SupportResources().coloredStrind(string: message, color: .systemOrange)
        
        guard let navBar = self.navigationController?.navigationBar else { return }
        navBar.addSubview(messagePopupView)
        
        // First position hiden
        let firstPosition = CGAffineTransform(translationX: 0.0, y: -(self.view.bounds.height + 1.0))
        messagePopupView.transform = firstPosition
        
        // Show
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) { [self] in
            let moveToBottom = CGAffineTransform(translationX: 0.0, y: +(self.view.bounds.height * 0.0))
            messagePopupView.transform = moveToBottom
        } completion: { _ in
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
        
        // HIde
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { timer in
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                let moveToTop = CGAffineTransform(translationX: 0.0, y: -(self.view.bounds.height * 0.9))
                messagePopupView.transform = moveToTop
            } completion: { _ in
                messagePopupView.removeFromSuperview()
            }
        }
        
        messagePopupView.topAnchor.constraint(equalTo: navBar.topAnchor , constant: 8).isActive = true
        messagePopupView.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 60).isActive = true
        messagePopupView.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -60).isActive = true
        messagePopupView.heightAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
        
    }
    
    // MARK: Button Is Valid
    func buttonIsValid(button: UIButton, bool: Bool) {
        
        if bool == true {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
                button.alpha = 1
            } completion: { _ in}
        } else {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
                button.alpha = 0
            } completion: { _ in}
        }
    }
    
    
    
    
}
