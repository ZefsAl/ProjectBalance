//
//  AmountTextField.swift
//  CryptoBalance
//
//  Created by Serj on 23.02.2023.
//

import UIKit


class AmountTextField: UITextField, UITextFieldDelegate {
    
    
    // Annotation
    // Изменен регион в билде «Продукт»> «Схема»> «Редактировать схему»> «Параметры»> «Регион приложения» -> установить значение «США» для "."
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemGray5
        layer.cornerRadius = 12
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        delegate = self
        textColor = .white
        attributedPlaceholder = NSAttributedString(string: "00000000.00000000", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        
        font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        tintColor = .white
        
        
        //Margins insid
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        leftViewMode = .always
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        rightViewMode = .always
        
        self.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        keyboardType = .decimalPad
        
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let newTextField = textField.text else { return false }

        
        if (string == "," || string == "." ) {
            
            if (newTextField.contains(",") || newTextField.contains(".")) {
                
                return false
            }
        }
        
        
        
        if !string.isEmpty {
            let text = newTextField as NSString
            let newText = text.replacingCharacters(in: range, with: string)
            if let regex = try? NSRegularExpression(pattern: "^[0-9]{0,12}$*((\\.|,)[0-9]{0,5})?$", options: .caseInsensitive) {
                return regex.numberOfMatches(in: newText, options: .reportProgress, range: NSRange(location: 0, length: (newText as NSString).length)) > 0
            }
            return false
        }
        
        
        return true
        
        //        @"^[0-9]{0,3}$*((\\.|,)[0-9]{0,2})?$"
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


