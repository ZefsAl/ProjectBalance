//
//  JsonGetRate.swift
//  CryptoBalance
//
//  Created by Serj on 23.02.2023.
//

import Foundation

class JsonGetRate: Codable {
    
    let adapter, from, fromNetwork, to: String
    let toNetwork: String
    let amountFrom, amountTo, minAmount, maxAmount: Double
    let quotaID: String
    let time: Int
    
    enum CodingKeys: String, CodingKey {
        case adapter, from, fromNetwork, to, toNetwork, amountFrom, amountTo, minAmount, maxAmount
        case quotaID = "quotaId"
        case time
    }
}


