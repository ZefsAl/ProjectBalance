//
//  ExchangeModel.swift
//  CryptoBalance
//
//  Created by Serj on 17.02.2023.
//

import Foundation

struct JsonSupportedCurrencies: Codable {
    let name: String
    let ticker: String
    let network: String
    let smartContract: String?
    let alias: [String]?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case ticker = "ticker"
        case network = "network"
        case smartContract = "smartContract"
        case alias = "alias"
    }
}

