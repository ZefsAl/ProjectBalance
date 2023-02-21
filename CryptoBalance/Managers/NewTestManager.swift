//
//  NewTestManager.swift
//  CryptoBalance
//
//  Created by Serj on 17.02.2023.
//

import Foundation

class NewTestManager {
    
    
    func newTestRequest() {
        
        let urlString = URL(string: "https://api.swapzone.io/v1/exchange/currencies")!
        
        var request = URLRequest(url: urlString)
//        request.setValue("VQ3ZyhxRp", forHTTPHeaderField: "x-api-key")
//        request.setValue("x-api-key", forHTTPHeaderField: "VQ3ZyhxRp")
        request.addValue("VQ3ZyhxRp", forHTTPHeaderField: "x-api-key")

        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let data = data else { return }
            
            let strData = String(decoding: data, as: UTF8.self)
            print(strData)
//            print()
            if let error = error {
                print("Have Error \(error)")
            }
            
        }
        task.resume()
        
        
        
    }
}
