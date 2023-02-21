//
//  ExchangeManager.swift
//  CryptoBalance
//
//  Created by Serj on 17.02.2023.
//

import Foundation


class ExchangeManager {
    
    
//    private let decoder = JSONDecoder()
//    private let session = URLSession
    private let session = URLSession.shared
    private let key = "VQ3ZyhxRp"
    
    
    func getSupportedCurrencies(completion: @escaping ([JsonSupportedCurrencies]) -> Void) {
        let urlString = "https://api.swapzone.io/v1/exchange/currencies"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.setValue(key, forHTTPHeaderField: "x-api-key")
        request.httpMethod = "GET"
        
//        let decoder = JSONDecoder()
        
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
//            print( "getSupportedCurrencies task - fetch data \(String(decoding: data, as: UTF8.self))" )
            do {
                let val = try JSONDecoder().decode([JsonSupportedCurrencies].self, from: data)
//                print(val)
                completion(val)
                
                
            } catch {
                print("Error Decoding: \(error)")
            }
            
            if let error = error {
                print("Have Error \(error)")
            }

        }
        task.resume()
    }
    
    

    
}

