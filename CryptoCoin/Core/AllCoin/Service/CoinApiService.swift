//
//  CoinApiService.swift
//  CryptoCoin
//
//  Created by Abrar Hamim on 24/8/24.
//

import Foundation

class CoinApiService: HTTPDataDownloader {
    
    init () {
        print("DEBUG: get init service")
    }
    
    private var baseURLString: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.coingecko.com"
        components.path = "/api/v3/coins/"
  
        return components
    }
    
    private var allCoinURL: String? {
        var components = baseURLString
        components.path += "markets"
        
        components.queryItems = [
            .init(name: "vs_currency", value: "usd"),
            .init(name: "order", value: "market_cap_desc"),
            .init(name: "per_page", value: "20"),
            .init(name: "price_change_percentage", value: "24h")
        ]
        return components.url?.absoluteString
    }
    
    func coinDetailsUrlString (id: String) -> String? {
        var component = baseURLString
        component.path += "\(id)"
        
        component.queryItems = [
            .init(name: "localization", value: "false")
        ]
        return component.url?.absoluteString
    }
   
    
//    private var url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&price_change_percentage=24h&locale=en"
    
    
    func fatchCoinwithAsync() async throws -> [Coin] {
        guard let endpoint = allCoinURL else { 
            throw CoinApiError.requestfailed(Description: "Invalid data")
        }
        return try await CoinDetailGeneric(as: [Coin].self, endPoint: endpoint)
        
    }
    
    //MARK: - Coin Details API fatch Data
    
    func CoinDetail(id:String) async throws -> CoinDetails? {
   //     let CoindetailUrl = "https://api.coingecko.com/api/v3/coins/\(id)?localization=false"
        if let cache = CoinDetailsCache.shared.get(forKey: id) {
            print("get cache data")
            return cache
        }
        
        guard let endpoint = coinDetailsUrlString(id: id) else {
            throw CoinApiError.requestfailed(Description: "Api error")
        }
        
        let details =  try await CoinDetailGeneric(as: CoinDetails.self, endPoint: endpoint)
        print("get for api")
        CoinDetailsCache.shared.set(details, forkey: id)
        return details

    }
    
    
    
    
    
    
    //MARK: - Completion handler
    
    func fatchcoinwithPriceWithCompletionHandelar(completion: @escaping(Result<[Coin],CoinApiError>)->Void) {
        guard let url = URL(string: allCoinURL ?? "") else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.requestfailed(Description: "request failed")))
                return
            }
            
            guard response.statusCode == 200 else {
                completion(.failure(.invalidStatusCode(statusCode: response.statusCode)))
                print("response status code invalid")
                return
            }
            
            guard let data = data else {
                completion(.failure(.jsonParsingFailure))
                print("data invalid")
                return
            }
            
            do {
                let coins = try JSONDecoder().decode([Coin].self, from: data)
                completion(.success(coins))
            } catch {
                print("DEBUG this is a error: \(error)")
                completion(.failure(.unknowError(error: error.localizedDescription as! Error)))
                
                return
            }
        }.resume()
        
    }
}
