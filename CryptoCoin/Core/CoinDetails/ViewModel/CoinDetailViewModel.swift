//
//  CoinDetailViewModel.swift
//  CryptoCoin
//
//  Created by Abrar Hamim on 24/8/24.
//

import Foundation

class CoinDetailViewModel: ObservableObject {
    
    private var service: CoinApiProtocal
    private var coinId: String
    
    @Published var coindetail: CoinDetails?
    
    init(CoinId: String, service: CoinApiProtocal){
      self.service = service
        self.coinId = CoinId
            Task { await fatchCoinDetail() }
    }
    
    @MainActor
    func fatchCoinDetail() async {
        do{
            self.coindetail = try await service.CoinDetail(id: coinId)
        } catch {
            print("DEBUG: \(error.localizedDescription)")
        }
    }
}
