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
            
            print( "getSupportedCurrencies task - fetch data \(String(decoding: data, as: UTF8.self))" ) // test
            
            do {
                let val = try JSONDecoder().decode([JsonSupportedCurrencies].self, from: data)
                //                print(val) - test
                completion(val)
            } catch {
                print("Error Decoding getSupportedCurrencies: \(error)")
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
    
    
    // MARK: Get Limits
    func getLimits(fromTicker: String, toTicker: String, completion: @escaping (JsonGetLimits) -> Void) {
        let urlString = "https://api.swapzone.io/v1/exchange/get-limits?from=\(fromTicker)&to=\(toTicker)&rateType=all"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.setValue(key, forHTTPHeaderField: "x-api-key")
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            print( "Get Limits - fetch data \(String(decoding: data, as: UTF8.self))" ) // test
            
            do {
                let val = try JSONDecoder().decode(JsonGetLimits.self, from: data)
                //                print(val) - test
                completion(val)
            } catch {
                print("Error Decoding: \(error)")
            }
        }
        task.resume()
    }

    
    // MARK: Validate Address
    func validateAddress(ticker: String, address: String, completion: @escaping (JsonValidateAddress) -> Void) {
        
        let urlString = "https://api.swapzone.io/v1/exchange/validate/address?currency=\(ticker)&address=\(address)"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.setValue(key, forHTTPHeaderField: "x-api-key")
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            print( "Validate Address - fetch data \(String(decoding: data, as: UTF8.self))" ) // test
            
            do {
                let val = try JSONDecoder().decode(JsonValidateAddress.self, from: data)
                //                print(val) - test
                completion(val)
            } catch {
                print("Error Decoding: \(error)")
            }
        }
        task.resume()
    }
    
    
    
    
    
    
    
    
    
    
    
    // MARK: GET Rate
    func getRate(from: String, to: String, amountFrom: String, completion: @escaping (JsonGetRate) -> Void) {
        //  https://api.swapzone.io/v1/exchange/get-rate?from=btc&to=doge&amount=0.1&rateType=all&availableInUSA=false&chooseRate=best&noRefundAddress=false
        
        let urlString = "https://api.swapzone.io/v1/exchange/get-rate?from=\(from)&to=\(to)&amount=\(amountFrom)&rateType=all&availableInUSA=false&chooseRate=best&noRefundAddress=false"
        
        
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.setValue(key, forHTTPHeaderField: "x-api-key")
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            //            print( "Get Rate task - fetch data \(String(decoding: data, as: UTF8.self))" ) // test
            do {
                let val = try JSONDecoder().decode(JsonGetRate.self, from: data)
                //                print("DECODED: \(val)") // test
                //                print("DECODED: \(String(describing: val.error))") // test
                
                completion(val)
                
            } catch {
                print("Error Decoding getRate: \(error)")
            }
            
            
            if let error = error {
                print("Error getRate \(error)")
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
    
    
    
    
    // MARK: POST Create Transaction
    func postCreateTransaction(fromTiker: String, toTicker: String, amountDeposit: String, addressReceive: String, refundAddress: String, refundExtraId: String, quotaId: String, completion: @escaping (JsonTransactionStatus) -> Void  ) {
        
        let urlString = "https://api.swapzone.io/v1/exchange/create"
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.setValue(key, forHTTPHeaderField: "x-api-key")
        request.httpMethod = "POST"
        
        //        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        components?.queryItems = [
            URLQueryItem(name: "from", value: fromTiker),
            URLQueryItem(name: "to", value: toTicker),
            URLQueryItem(name: "amountDeposit", value: amountDeposit),
            URLQueryItem(name: "addressReceive", value: addressReceive),
            URLQueryItem(name: "extraIdReceive", value: ""),
            URLQueryItem(name: "refundAddress", value: refundAddress),
            URLQueryItem(name: "refundExtraId", value: refundExtraId),
            URLQueryItem(name: "quotaId", value: quotaId),
            
            URLQueryItem(name: "noQuotaId", value: ""),
            URLQueryItem(name: "fromNetwork", value: ""),
            URLQueryItem(name: "toNetwork", value: ""),
            URLQueryItem(name: "noRefundAddress", value: "")
        ]
        
        //        components?.queryItems = [
        //            URLQueryItem(name: "from", value: "btc"),
        //            URLQueryItem(name: "to", value: "doge"),
        //            URLQueryItem(name: "amountDeposit", value: "0.11"),
        //            URLQueryItem(name: "addressReceive", value: "DFundmtrigzA6E25Swr2pRe4Eb79bGP8G1"),
        //            URLQueryItem(name: "extraIdReceive", value: ""),
        //            URLQueryItem(name: "refundAddress", value: "1Mz7153HMuxXTuR2R1t78mGSdzaAtNbBWX"),
        //            URLQueryItem(name: "refundExtraId", value: ""),
        //            URLQueryItem(name: "quotaId", value: "602526208eb61758b8adb7dd"),
        //            URLQueryItem(name: "noQuotaId", value: ""),
        //            URLQueryItem(name: "fromNetwork", value: ""),
        //            URLQueryItem(name: "toNetwork", value: ""),
        //            URLQueryItem(name: "noRefundAddress", value: "")
        //        ]
        
        let query = components?.url?.query
        guard let query = query else { print("Error query components"); return }
        
        request.httpBody = Data(query.utf8)
        
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard
                let data = data,
                //                let response = response as? HTTPURLResponse,
                error == nil
            else {
                print("error", error ?? URLError(.badServerResponse))
                return
            }
            
            print( "POST Create Transaction - fetch data \(String(decoding: data, as: UTF8.self))" ) // test
            
            do {
                let val = try JSONDecoder().decode(JsonTransactionStatus.self, from: data)
                print("\(val)")
                completion(val)
            } catch {
                print("ERROR decode - POST Create Transaction \(error)")
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
        // End POST
    }
    
    
    
    
    
    
    
    // MARK: Get Transaction Status
    func getTransactionStatus(id: String, completion: @escaping (JsonTransactionStatus) -> Void) {
        
        
        let urlString = "https://api.swapzone.io/v1/exchange/tx?id=\(id)"
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.setValue(key, forHTTPHeaderField: "x-api-key")
        request.httpMethod = "GET"
        
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            print( "Get Transaction Status - fetch data \(String(decoding: data, as: UTF8.self))" ) // test
            
            do {
                let val = try JSONDecoder().decode(JsonTransactionStatus.self, from: data)
                
                print(val)
                
                completion(val)
                
            } catch {
                print("Error Decoding Transaction: \(error)")
            }
            
            
        }
        task.resume()
        
    }
    
    
    
    
    
}

