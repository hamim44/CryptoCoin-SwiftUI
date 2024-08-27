//
//  CoinDetailView.swift
//  CryptoCoin
//
//  Created by Abrar Hamim on 24/8/24.
//

import SwiftUI
import Kingfisher

struct CoinDetailView: View {
    
    let coin: Coin
    
//    @EnvironmentObject var dvm: CoinviewModel
    
    @ObservedObject var dvm: CoinDetailViewModel
    
    init(coin: Coin,service: CoinApiProtocal) {
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
                    HStack {
                        VStack(alignment:.leading,spacing: 2){
                            Text(details.name)
                                .fontWeight(.semibold)
                                .font(.subheadline)
                            
                            Text(details.symbol.uppercased())
                                .font(.footnote)
                        }
                        Spacer()
                        
                        KFImage(URL(string: coin.image))
                            .resizable()
                            .frame(width: 64, height: 64)
                    }
                    
                    Text(details.description.text)
                        .font(.footnote)
                        .padding(.vertical,12)
                }
                
            }
//            .task{
//                await dvm.fatchCoinDetail()
//    //            await dvm.fatchCoinDetail(coinId: coin.id)
//            }
            .padding(.horizontal)
        }
    }
    }


//#Preview {
//    CoinDetailView()
//}
