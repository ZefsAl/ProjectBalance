//
//  JsonGetLimits.swift
//  CryptoBalance
//
//  Created by Serj on 04.04.2023.
//

import Foundation


struct JsonGetLimits: Codable {
    let from, fromNetwork, to, toNetwork: String
    let minAmount, maxAmount: Double?
}
