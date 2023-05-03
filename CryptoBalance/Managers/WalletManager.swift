//
//  NetworkManager2.swift
//  CryptoBalance
//
//  Created by Serj on 01.01.2023.
//

import Foundation

// Классические запросы, до 3 запросов/сек и 200 запросов/час
// https://api.blockcypher.com/v1/btc/main/addrs/1DEP8i3QJCsomS4BSMY2RpU1upv62aGvhD/balance

//    DFundmtrigzA6E25Swr2pRe4Eb79bGP8G1 - DOGE
//    bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh - BTC
//    1Mz7153HMuxXTuR2R1t78mGSdzaAtNbBWX - BTC
//    XpESxaUmonkq8RaLLp46Brx2K39ggQe226 - Dash
//    3CDJNfdWX8m2NwuGUV3nhXHXEeLygMXoAj - Ltc (LTC/BTC)
//    31yB5p27QWwe2TGJFFQaxCAp26T8dLfPnw - BTC = 0
//    1FfmbHfnpaZjKFvyi1okTjJJusN455paPH - BTC = ~ 1.20724504


class WalletManager {
    
    func queryBalance(network: String, address: String, completion: @escaping (JsonBalanceModel) -> Void) {
        
        guard let url = URL(string: "https://api.blockcypher.com/v1/\(network)/main/addrs/\(address)/balance") else { return }
        
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let decoder = JSONDecoder()
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            print( "Wallet task - fetch data \(String(decoding: data, as: UTF8.self))" ) // test
            
            
            if (error != nil)  {
                print("have Error in NetworkManager")
            } else {
                do {
                    let val = try decoder.decode(JsonBalanceModel.self, from: data)
//                     print( "Fetch data decoding! \(val)" ) // TEST
                    completion(val)
                    
                } catch let error as NSError {
                    print("Error Decoding: \(error.localizedDescription)")
                }
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                
                switch httpResponse.statusCode {
                case 100..<200:
                    print("informational")
                case 200..<300:
                    print("success")
                case 300..<400:
                    print("redirection")
                case 400..<500:
                    print("clientError")
                case 500..<600:
                    print("serverError")
                
                default:
                    print("undefined")
                }
            }
            
            
            
            
            
        }
        task.resume()
    }
    
}



