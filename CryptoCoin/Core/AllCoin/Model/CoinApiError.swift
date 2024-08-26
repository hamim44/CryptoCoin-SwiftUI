//
//  CoinApiError.swift
//  CryptoCoin
//
//  Created by Abrar Hamim on 24/8/24.
//

import Foundation

//
//  CoinApiError.swift
//  CoinPrice
//
//  Created by Abrar Hamim on 24/8/24.
//

import Foundation

enum CoinApiError: Error {
    case invalidData
    case jsonParsingFailure
    case requestfailed(Description: String)
    case invalidStatusCode(statusCode: Int)
    case unknowError(error: Error)
    
    var CustomErrorDescription: String {
        switch self {
        case .invalidData:
            return "invalid data"
        case .jsonParsingFailure:
            return "failed to parse JSON"
        case let .requestfailed( Description):
            return "Request faild: \(Description)"
        case let .invalidStatusCode( statusCode):
            return "Invalid Status Code \(statusCode)"
        case let .unknowError( error):
            return "unkown Error :\(error)"
        }
    }
    
}
