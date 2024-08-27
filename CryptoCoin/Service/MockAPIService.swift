//
//  MockAPIService.swift
//  CryptoCoin
//
//  Created by Abrar Hamim on 26/8/24.
//

import Foundation

class MockAPIService: CoinApiProtocal {
    
    var MockData: Data?
    var MockError: CoinApiError?
    
    func fatchCoinwithAsync() async throws -> [Coin] {
        if let MockError {throw MockError}
        do {
            let coin = try JSONDecoder().decode([Coin].self, from: MockData ?? testableCoinData_marketCapDesc)
            return coin
        } catch {
            throw error as? CoinApiError ?? .unknowError(error: error)
        }
    }
    
    func CoinDetail(id: String) async throws -> CoinDetails? {
        let discpition = Discription(text: "Bitcoin id ")
        
        let bitcoinDetails = CoinDetails(name: "BitCoin", id: "1", symbol: "bitcoin", description: discpition)
        return bitcoinDetails
    }
    
    
}
