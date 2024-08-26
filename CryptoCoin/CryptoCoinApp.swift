//
//  CryptoCoinApp.swift
//  CryptoCoin
//
//  Created by Abrar Hamim on 24/8/24.
//

import SwiftUI

@main
struct CryptoCoinApp: App {
    @StateObject var viewModel = CoinviewModel(service: CoinApiService())
    var body: some Scene {
        WindowGroup {
//            ContentView(service: CoinApiService())
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
