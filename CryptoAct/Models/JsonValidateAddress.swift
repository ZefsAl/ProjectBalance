//
//  JsonValidateAddress.swift
//  CryptoBalance
//
//  Created by Serj on 10.04.2023.
//

import Foundation

struct JsonValidateAddress: Codable {
    let result: Bool?
    let message: String?
    let error: Bool?
    
    enum CodingKeys: String, CodingKey {
        case result = "result"
        case message = "message"
        case error = "error"
        
    }
    
}
