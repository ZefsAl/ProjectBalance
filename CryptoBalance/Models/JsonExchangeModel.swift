//
//  ExchangeModel.swift
//  CryptoBalance
//
//  Created by Serj on 17.02.2023.
//

import Foundation

struct SupportedCurrencies: Codable {
    let name, ticker, network: String
    let smartContract: String?
    let alias: [String]
}
