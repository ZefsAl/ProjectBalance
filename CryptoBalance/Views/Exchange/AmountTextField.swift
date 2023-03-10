//
//  AmountTextField.swift
//  CryptoBalance
//
//  Created by Serj on 23.02.2023.
//

import UIKit

class AmountTextField: UITextField, UITextFieldDelegate {
    
    // MARK: Right Cancel Button
    let rightCancelButton: UIButton = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(systemName: "xmark.circle.fill")
        iv.tintColor = .systemGray
        iv.contentMode = .left

        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        
        b.addSubview(iv)
        
        iv.centerYAnchor.constraint(equalTo: b.centerYAnchor).isActive = true
        iv.leadingAnchor.constraint(equalTo: b.leadingAnchor).isActive = true
        
        b.addTarget(Any?.self, action: #selector(cancelAction), for: .touchUpInside)
        
        b.isHidden = true
        b.alpha = 0
        
        return b
    }()
    
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemGray5
        layer.cornerRadius = 12
//        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        delegate = self
        textColor = .white
        attributedPlaceholder = NSAttributedString(string: "0.00000", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        tintColor = .white
        
        
        // Margins inside
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        leftViewMode = .always
        rightView = rightCancelButton
        rightViewMode = .always
        
        
        self.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.keyboardType = .numberPad
        self.addDoneButtonOnKeyboard()
        
        
    }
    
    // MARK: Cancel Action
    @objc func cancelAction() {
//        print("Clear")
        self.text = ""
    }
    
    // MARK: Animate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.rightCancelButton.isHidden = false
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
            self.rightCancelButton.alpha = 1
        }, completion: nil)

    }
    
    // MARK: Animate
    func textFieldDidEndEditing(_ textField: UITextField) {

        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut) {
            self.rightCancelButton.alpha = 0
        } completion: { _ in
            self.rightCancelButton.isHidden = true
        }

    }
    
    
    // MARK: Input Validation Delegate 
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        guard let newTextField = textField.text else { return false }
        
        if string == "," {
            return false
        }
        // Так выглядит ограничение для колличества 1 точки
        if string == "." {
            if  newTextField.contains(".") {
                return false
            }
        }
        // Формат @"^[0-9]{0,3}$*((\\.|,)[0-9]{0,2})?$"
        if !string.isEmpty {
            let text = newTextField as NSString
            let newText = text.replacingCharacters(in: range, with: string)
            if let regex = try? NSRegularExpression(pattern: "^[0-9]{0,16}$*((\\.|,)[0-9]{0,5})?$", options: .caseInsensitive) {
                return regex.numberOfMatches(in: newText, options: .reportProgress, range: NSRange(location: 0, length: (newText as NSString).length)) > 0
            }
            return false
        }
        return true
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: Extension Accessory View
extension AmountTextField {
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        doneToolbar.backgroundColor = .systemGray5
        
        let dotButton: UIButton = {
            let b = UIButton(type: .system)
            b.translatesAutoresizingMaskIntoConstraints = false
            b.layer.cornerRadius = 6
            b.backgroundColor = .systemGray2
            b.widthAnchor.constraint(equalToConstant: 60).isActive = true
            b.heightAnchor.constraint(equalToConstant: 30).isActive = true
            
            let l = UILabel()
            l.translatesAutoresizingMaskIntoConstraints = false
            l.isUserInteractionEnabled = false
            l.textColor = .white
            l.text = "."
            l.font = UIFont.systemFont(ofSize: 17, weight: .bold)
            
            b.addSubview(l)
            l.centerXAnchor.constraint(equalTo: b.centerXAnchor).isActive = true
            l.centerYAnchor.constraint(equalTo: b.centerYAnchor).isActive = true
            
            b.addTarget(Any?.self, action: #selector(dotButtonAction), for: .touchUpInside)
            return b
        }()
        
        let dot: UIBarButtonItem = UIBarButtonItem(customView: dotButton)
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Check", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneButtonAction))
        done.tintColor = .white
        
        let items = [dot,flexSpace, done]
        doneToolbar.items = items
        
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
    
    @objc func dotButtonAction() {
//        print("Dot button clicked")
        guard let newTextField = self.text else { return }
        // Так выглядит ограничение для колличества 1 точки
        if !newTextField.contains(".") {
            self.text = newTextField + "."
        }
    }
    
}
