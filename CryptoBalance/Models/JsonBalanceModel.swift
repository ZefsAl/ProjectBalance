//
//  DataModel.swift
//  CryptoBalance
//
//  Created by Serj on 31.12.2022.
//

import Foundation

// Единица измерения баланса сатоши то есть 10^8
struct JsonBalanceModel: Codable {
    let address: String
    let totalReceived: Int
    let totalSent: Int
    let balance: Int
    let unconfirmedBalance: Int
    let finalBalance: Int
    let nTx: Int
    let unconfirmedNTx: Int
    let finalNTX: Int

    enum CodingKeys: String, CodingKey {
        case address
        case totalReceived = "total_received"
        case totalSent = "total_sent"
        case balance
        case unconfirmedBalance = "unconfirmed_balance"
        case finalBalance = "final_balance"
        case nTx = "n_tx"
        case unconfirmedNTx = "unconfirmed_n_tx"
        case finalNTX = "final_n_tx"
    }
}
