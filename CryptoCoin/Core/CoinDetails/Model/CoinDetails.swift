//
//  CoinDetails.swift
//  CryptoCoin
//
//  Created by Abrar Hamim on 24/8/24.
//

import Foundation

struct CoinDetails: Codable {
    let name:String
    let id: String
    let symbol: String
    let description: Discription
}

struct Discription: Codable {
    let text: String
    
    enum CodingKeys : String, CodingKey {
        case text = "en"
    }
}
