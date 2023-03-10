//
//  AppData.swift
//  CryptoBalance
//
//  Created by Serj on 13.01.2023.
//

import Foundation
import UIKit

class SupportResources {
    
    let currencyArr: [String] = ["Not selected", "Dogecoin", "Bitcoin", "Litecoin", "Dash"]
    
    func getShortNetwork(string: String) -> String{
        switch string {
        case "Dogecoin":
            return "doge";
        case "Bitcoin":
            return "btc";
        case "Litecoin":
            return "ltc";
        case "Dash":
            return "dash";
        default:
            return "Not selected"
        }
    }
    
    func lyingString(string: String) -> String{
        switch string {
        case "doge":
            return "Dogecoin";
        case "btc":
            return "Bitcoin";
        case "ltc":
            return "Litecoin";
        case "dash":
            return "Dash";
        default:
            return "Not selected"
        }
    }
 
    
    func convertSatoshi(_ satohsi: Int) -> Decimal {
        let valOne = Decimal(satohsi)
        let valTwo = Decimal(100000000)
        let sum = valOne / valTwo
        return sum
    }
    
    func coloredStrind(string: String, color: UIColor) -> NSMutableAttributedString {
        
        let colorAttribute = [NSAttributedString.Key.foregroundColor: color]
        let fontAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .semibold)]
        
        let attributedString = NSMutableAttributedString()
        
        for letter in string.unicodeScalars {
//            let newLetter: NSAttributedString
            let newFont: NSAttributedString
            
            if CharacterSet.decimalDigits.contains(letter) {
                // Цвет
//                newLetter = NSAttributedString(string: "\(letter)", attributes: colorAttribute)
                // Шрифт
                newFont = NSAttributedString(string: "\(letter)", attributes: fontAttribute)
                
            } else {
//                newLetter = NSAttributedString(string: "\(letter)")
                newFont = NSAttributedString(string: "\(letter)")
            }
            
            attributedString.append(newFont)
            
//            attributedString.append(newLetter)
            
            
        }
        return attributedString
//        lable.attributedText = attributedString
    
    }
    
    
    
    init(){}
}





    
