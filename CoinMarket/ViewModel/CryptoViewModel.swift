//
//  CryptoViewModel.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 14/09/2023.
//

import Foundation
import Combine

class CryptoViewModel: ObservableObject {
    @Published var allCoins: [Coin] = []
    @Published var filterCoins: [Coin] = []

    private let coinManager = CoinManager()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        downloadCoinData() {
            self.getFilterCoin(query:"")
        }
    }
    
    func downloadCoinData(complete: (() -> Void)? = nil) {
        coinManager.$coins.sink {[weak self] coinData in
            self?.allCoins = coinData
            complete?()
        }.store(in: &cancellable)
        
    }
    
    func getFilterCoin(query : String) {
        var tmpCoins: [Coin] = []
        if query == "" {
            filterCoins = allCoins
        } else {
            for coin in allCoins {
                print(coin.symbol)
                if coin.name.lowercased().hasPrefix(query.lowercased()) || coin.symbol.lowercased().hasPrefix(query.lowercased()) {
                    tmpCoins.append(coin)
                }
            }
            filterCoins = tmpCoins
        }
    }
}
