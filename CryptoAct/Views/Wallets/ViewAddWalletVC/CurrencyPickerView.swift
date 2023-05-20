//
//  CurrencyPickerView.swift
//  CryptoBalance
//
//  Created by Serj on 14.01.2023.
//

import UIKit

protocol CurrencyPickerProtocol: AnyObject {
    func didSelect(row: Int )
}


class CurrencyPickerView: UIPickerView {
    weak var currencyDelegate: CurrencyPickerProtocol?
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        delegate = self
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CurrencyPickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        SupportResources().currencyArr[row]
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currencyDelegate?.didSelect(row: row)
        
    }
}

extension CurrencyPickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        AppDataResources.Currency.allCases.count
        SupportResources().currencyArr.count
    }
}
