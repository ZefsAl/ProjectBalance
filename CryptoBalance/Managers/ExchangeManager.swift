//
//  ExchangeManager.swift
//  CryptoBalance
//
//  Created by Serj on 17.02.2023.
//

import Foundation


class ExchangeManager {
    
    private let session = URLSession.shared
    private let key = "VQ3ZyhxRp"
    
// MARK: GET Supported Currencies
    func getSupportedCurrencies(completion: @escaping ([JsonSupportedCurrencies]) -> Void) {
        let urlString = "https://api.swapzone.io/v1/exchange/currencies"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.setValue(key, forHTTPHeaderField: "x-api-key")
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
//            print( "getSupportedCurrencies task - fetch data \(String(decoding: data, as: UTF8.self))" ) // test
            do {
                let val = try JSONDecoder().decode([JsonSupportedCurrencies].self, from: data)
//                print(val) - test
                completion(val)
            } catch {
                print("Error Decoding: \(error)")
            }
            
            if let error = error {
                print("Error getSupportedCurrencies \(error)")
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
    
    
// MARK: GET Rate
// from: String, to: String, amountFrom: String, completion: @escaping (JsonGetRate) -> Void
    func getRate(from: String, to: String, amountFrom: String, completion: @escaping (JsonGetRate) -> Void) {
//  https://api.swapzone.io/v1/exchange/get-rate?from=btc&to=doge&amount=0.1&rateType=all&availableInUSA=false&chooseRate=best&noRefundAddress=false
        
        let urlString = "https://api.swapzone.io/v1/exchange/get-rate?from=\(from)&to=\(to)&amount=\(amountFrom)&rateType=all&availableInUSA=false&chooseRate=best&noRefundAddress=false"
        
//        let urlString = "https://api.swapzone.io/v1/exchange/get-rate?from=btc&to=doge&amount=0.1&rateType=all&availableInUSA=false&chooseRate=best&noRefundAddress=false"
        
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.setValue(key, forHTTPHeaderField: "x-api-key")
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            print( "Get Rate task - fetch data \(String(decoding: data, as: UTF8.self))" ) // test
            do {
                let val = try JSONDecoder().decode(JsonGetRate.self, from: data)
                
                print("DECODED: \(val)") // test
//                print("DECODED: \(String(describing: val.error))") // test
                
                completion(val)
            } catch {
                print("Error Decoding: \(error)")
            }
            
            if let error = error {
                print("Error getSupportedCurrencies \(error)")
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

