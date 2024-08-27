//
//  CryptoCoinTests.swift
//  CryptoCoinTests
//
//  Created by Abrar Hamim on 27/8/24.
//

import XCTest
@testable import CryptoCoin

final class CryptoCoinTests: XCTestCase {

    func test_decodeTestIntoArray_marketCapDesc() throws {
        do {
            let coin = try JSONDecoder().decode([Coin].self, from: testableCoinData_marketCapDesc)
            XCTAssertTrue(coin.count > 0)//ensures that coins array has coin
            XCTAssertFalse(coin.isEmpty)
            XCTAssertEqual(coin.count, 20) //ensure all the coin here decode
            XCTAssertEqual(coin, coin.sorted(by: { $0.marketCapRank < $1.marketCapRank }))// ensure sorting Order
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        
    }
}
