//
//  CoinviewModel.swift
//  CryptoCoin
//
//  Created by Abrar Hamim on 24/8/24.
//

import Foundation

class CoinviewModel: ObservableObject {
    
    @Published var Coins = [Coin]()
    @Published var errorMessage:String?
    
//    @Published var coindetail: CoinDetails?
    
    private var service: CoinApiProtocal
    
    init(service: CoinApiProtocal) {
        self.service = service
        Task { await fatchCoinWithAsyscthowrs() }
    }
    
    @MainActor
    func fatchCoinWithAsyscthowrs() async {
        do {
            self.Coins =  try await service.fatchCoinwithAsync()
        } catch {
            
            guard let error = error as? CoinApiError else { return }
            self.errorMessage = error.CustomErrorDescription
//            if let error = error as? CoinApiError {
//                self.errorMessage = error.CustomErrorDescription
//            } else {
//                self.errorMessage = error.localizedDescription
//            }
        }
    }
    
    
    
//    @MainActor
//    func fatchCoinDetail(coinId:String) async {
//        do{
//            self.coindetail = try await service.CoinDetail(id: coinId)
//        } catch {
//            print("DEBUG: \(error.localizedDescription)")
//        }
//    }
    
//    func fatchCoinWithCompletionHandler(){
//        service.fatchcoinwithPriceWithCompletionHandelar { [weak self] results in
//            DispatchQueue.main.async {
//                switch results {
//                case .success(let coin):
//                    self?.Coins = coin
//                case .failure(let error):
//                    self?.errorMessage = error.localizedDescription
//                }
//            }
//        }
//    }
    
}
