//
//  JsonGetRate.swift
//  CryptoBalance
//
//  Created by Serj on 23.02.2023.
//

import Foundation

class JsonGetRate: Codable {
    
    let adapter, from, fromNetwork, to: String?
    let toNetwork: String?
    let amountFrom, amountTo, minAmount, maxAmount: Double?
    let quotaID: String?
    let time: Int?
    let validUntil: String?
    
    let error: Bool?
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case adapter, from, fromNetwork, to, toNetwork, amountFrom, amountTo, minAmount, maxAmount
        case quotaID = "quotaId"
        case time, validUntil
        case error, message
    }
}

//class JsonGetRateError: Codable {
//
//    let error: String?
//    let message: String?
//
//    enum CodingKeys: String, CodingKey {
//        case error, message
//    }
//}

//{
//    "error": true,
//    "message": "Couldn’t get rate for this pair. Try amount between 0.01105 and 88867.27227.."
//}


