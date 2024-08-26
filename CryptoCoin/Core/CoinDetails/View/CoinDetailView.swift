//
//  CoinDetailView.swift
//  CryptoCoin
//
//  Created by Abrar Hamim on 24/8/24.
//

import SwiftUI

struct CoinDetailView: View {
    
    let coin: Coin
    
//    @EnvironmentObject var dvm: CoinviewModel
    
    @ObservedObject var dvm: CoinDetailViewModel
    
    init(coin: Coin,service: CoinApiService) {
        self.coin = coin
        self.dvm = CoinDetailViewModel(CoinId: coin.id, service: service)
    }
    
    
    
//    init(coin: Coin) {
//        self.coin = coin
//        self.dvm = CoinDetailViewModel(CoinId: coin.id, service: service)
//    }
//    
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                if let details = dvm.coindetail {
                    Text(details.name)
                        .fontWeight(.semibold)
                        .font(.subheadline)
                    
                    Text(details.symbol.uppercased())
                        .font(.footnote)
                    
                    Text(details.description.text)
                        .font(.footnote)
                        .padding(.vertical)
                }
                
            }
            .task{
                await dvm.fatchCoinDetail()
    //            await dvm.fatchCoinDetail(coinId: coin.id)
            }
            .padding()
        }
    }
    }


//#Preview {
//    CoinDetailView()
//}
