//
//  Coin.swift
//  CryptoCoin
//
//  Created by Abrar Hamim on 24/8/24.
//

import Foundation

struct Coin: Codable,Identifiable,Hashable {
    let id:String
    let symbol: String
    let name: String
    let marketCapRank: Int
    let currentPrice: Double
    let image: String
    
    
    enum CodingKeys: String, CodingKey {
        case id,symbol,name,image
        case currentPrice = "current_price"
        case marketCapRank = "market_cap_rank"
        
    }
}
