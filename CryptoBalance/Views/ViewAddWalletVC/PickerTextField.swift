//
//  PickerTextField.swift
//  CryptoBalance
//
//  Created by Serj on 25.01.2023.
//

import UIKit

class PickerTextField: UITextField, CurrencyPickerProtocol {
    
    let currencyPickerView = CurrencyPickerView()

    func didSelect(row: Int) {
        self.text = SupportResources().currencyArr[row]
        if row == 0 {
            self.textColor = .lightGray
        } else {
            self.textColor = .white
        }
        self.resignFirstResponder()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        currencyPickerView.currencyDelegate = self
        
        self.inputView = currencyPickerView
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemGray5
        layer.cornerRadius = 12
        textColor = .lightGray
        text = "Not selected"
        
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        leftViewMode = .always
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        rightViewMode = .always
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  - (Disable Perform Actions)
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.null
    }
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        return []
    }
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    

    
}
