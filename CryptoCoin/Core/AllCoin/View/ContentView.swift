//
//  ContentView.swift
//  CryptoCoin
//
//  Created by Abrar Hamim on 24/8/24.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    private let service: CoinApiProtocal
    @StateObject var viewModel: CoinviewModel
//
//    @EnvironmentObject var viewModel: CoinviewModel
    
    init(service: CoinApiProtocal ) {
        self.service = service
        self._viewModel = StateObject(wrappedValue: CoinviewModel(service: service))
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.Coins) { coin in
                    NavigationLink(value: coin) {
                        HStack(spacing: 12) {
                            Text("\(coin.marketCapRank)")
                                .foregroundStyle(.gray)
//                            AsyncImage(url: URL(string: coin.image)) { image in
//                                image
//                                    .resizable()
//                                    .frame(width: 32, height: 32)
//                            } placeholder: {
//                                EmptyView()
//                            }
                            KFImage(URL(string: coin.image))
                                .resizable()
                                .frame(width: 32, height: 32)

                            
                            VStack (alignment:.leading,spacing: 3){
                                Text(coin.name)
                                    .fontWeight(.semibold)
    
                                Text(coin.symbol.uppercased())
                            }
                        }
                        .onAppear {
                            if coin == viewModel.Coins.last {
                                Task{ await viewModel.fatchCoinWithAsyscthowrs()}
                            }
                        }
                        .font(.footnote)
                            
                    }
                }
            }
            .navigationTitle("Coins")
            .navigationDestination(for: Coin.self,  destination: { coin in
                CoinDetailView(coin: coin, service: service)
//                CoinDetailView(coin: coin)
            })
            
            .overlay {
                if let errorMessage = viewModel.errorMessage{
                    Text(errorMessage)
                }
            }
            
        }
        .task {
            await viewModel.fatchCoinWithAsyscthowrs()
        }
        
    }
}

#Preview {
    ContentView(service: CoinApiService())
 
}
