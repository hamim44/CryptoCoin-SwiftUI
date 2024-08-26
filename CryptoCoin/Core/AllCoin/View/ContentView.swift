//
//  ContentView.swift
//  CryptoCoin
//
//  Created by Abrar Hamim on 24/8/24.
//

import SwiftUI

struct ContentView: View {
//    private let service: CoinApiService
//    @StateObject var vm: CoinviewModel
//    
    @EnvironmentObject var viewModel: CoinviewModel
    
//    init(service: CoinApiService ) {
//        self.service = service
//        self._vm = StateObject(wrappedValue: CoinviewModel(service: service))
//    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.Coins) { coin in
                    NavigationLink(value: coin) {
                        HStack(spacing: 12) {
                            Text("\(coin.marketCapRank)")
                                .foregroundStyle(.gray)
                            
                            VStack (alignment:.leading,spacing: 3){
                                Text(coin.name)
                                    .fontWeight(.semibold)
    
                                Text(coin.symbol.uppercased())
                            }
                            
                        }.font(.footnote)
                    }
                }
            }
            .navigationTitle("Coins")
            .navigationDestination(for: Coin.self,  destination: { coin in
//                CoinDetailView(coin: coin, service: service)
                CoinDetailView(coin: coin)
            })
            .overlay {
                if let errorMessage = viewModel.errorMessage{
                    Text(errorMessage)
                }
            }
            
        }
        
    }
}

#Preview {
 //   ContentView(service: CoinApiService())
    ContentView()
}
