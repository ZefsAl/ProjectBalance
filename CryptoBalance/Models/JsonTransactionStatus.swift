//
//  JsonCreateTransaction.swift
//  CryptoBalance
//
//  Created by Serj on 17.03.2023.
//

import Foundation

// MARK: POST Create Transaction

struct JsonTransactionStatus: Codable, Hashable {
    
    // MARK: Hashable
    static func == (lhs: JsonTransactionStatus, rhs: JsonTransactionStatus) -> Bool {
        return lhs.transaction == rhs.transaction
    }
    
    
    let transaction: Transaction?
    
    let error: Bool?
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case error = "error"
        case message = "message"
        case transaction = "transaction"
        
    }
}

struct Transaction: Codable, Hashable {
    
    let id, quotaID, from, fromNetwork: String?
    let toNetwork, to, status, addressReceive: String?
    let extraIDReceive: String?
    let addressDeposit: String?
    let extraIDDeposit: String?
    let amountDeposit: String?
    let amountEstimated: String?
    let payinHash, payoutHash, hashReceive, depositReceivedAt: JSONNull?
    let createdAt: String?
    let payTill: JSONNull?
    let fee: Double?
    let extraFee: Double?
    let refundExtraID, refundAddress, userUnique: String?
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case quotaID = "quotaId"
        case from, fromNetwork, toNetwork, to, status, addressReceive
        case extraIDReceive = "extraIdReceive"
        case addressDeposit
        case extraIDDeposit = "extraIdDeposit"
        case amountDeposit, amountEstimated, payinHash, payoutHash, hashReceive, depositReceivedAt, createdAt, payTill, fee, extraFee
        case refundExtraID = "refundExtraId"
        case refundAddress, userUnique
    }
}
