//
//  CoinViewModelTest.swift
//  CryptoCoinTests
//
//  Created by Abrar Hamim on 27/8/24.
//

import XCTest
@testable import CryptoCoin

class CoinViewModelTest: XCTestCase {
    
    func testInit() {
        let service = MockAPIService()
        let viewModel = CoinviewModel(service: service)
        
        XCTAssertNotNil(viewModel, "this view Model not nil")
    }
    
    
    func testSuccessFulCoinFatch() async {
        let service = MockAPIService()
        let viewModel = CoinviewModel(service: service)
        
        await viewModel.fatchCoinWithAsyscthowrs()
        XCTAssertFalse(viewModel.Coins.isEmpty)
        
        XCTAssertTrue(viewModel.Coins.count > 0)//ensures that coins array has coin
        XCTAssertFalse(viewModel.Coins.isEmpty)
        XCTAssertEqual(viewModel.Coins.count, 20) //ensure all the coin here decode
        XCTAssertEqual(viewModel.Coins, viewModel.Coins.sorted(by: { $0.marketCapRank < $1.marketCapRank }))
    }
    
    func testCoinfatchwithInvaliedJSON() async {
        let service = MockAPIService()
        service.MockData = test_invalidJSON
        
        let viewModel = CoinviewModel(service: service)
        
        await viewModel.fatchCoinWithAsyscthowrs()
        XCTAssertTrue(viewModel.Coins.isEmpty)
        XCTAssertNotNil(viewModel.errorMessage)
          
    }
    
    func test_throwsInvalidedDataError() async {
        let service = MockAPIService()
        service.MockError = CoinApiError.invalidData
        
        let viewModel = CoinviewModel(service: service)
        
        await viewModel.fatchCoinWithAsyscthowrs()
        
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.errorMessage,CoinApiError.invalidData.CustomErrorDescription)
        
    }
    
    func test_throwsInvalidedstatusCode() async {
        let service = MockAPIService()
        service.MockError = CoinApiError.invalidStatusCode(statusCode: 404)
        
        let viewModel = CoinviewModel(service: service)
        
        await viewModel.fatchCoinWithAsyscthowrs()
        
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.errorMessage,CoinApiError.invalidStatusCode(statusCode: 404).CustomErrorDescription)
        
    }
    
}

