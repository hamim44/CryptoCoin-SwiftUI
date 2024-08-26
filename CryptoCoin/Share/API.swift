//
//  API.swift
//  CryptoCoin
//
//  Created by Abrar Hamim on 25/8/24.
//

import Foundation

protocol HTTPDataDownloader {
    func CoinDetailGeneric<T: Decodable>(as type: T.Type,endPoint: String) async throws -> T
}

extension HTTPDataDownloader {
    
    //MARK: - Generic type
    
    func CoinDetailGeneric<T: Decodable>(as type: T.Type,endPoint: String) async throws -> T {
        
        guard let url = URL(string: endPoint) else {
            throw CoinApiError.invalidData
        }
        
        let(data,response) = try await  URLSession.shared.data(from: url)
        
        guard let response =  response as? HTTPURLResponse else {
            throw CoinApiError.requestfailed(Description: "Requrest Faild")
        }
        
        guard response.statusCode == 200 else {
            throw CoinApiError.invalidStatusCode(statusCode: response.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch  {
            print("DEBUG error is: \(error.localizedDescription)")
            throw error as? CoinApiError ?? .unknowError(error: error)
        }
        
    }
    
}

