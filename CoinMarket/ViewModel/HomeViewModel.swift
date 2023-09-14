//
//  HomeViewModel.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 12/09/2023.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var allCoins: [Coin] = []
    
    private let coinManager = CoinManager()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        downloadCoinData()
    }
    
    func getTopCoins() -> [Coin] {
        var topCoins: [Coin] = []
        
        var count = 0;
        for coin in allCoins.sorted(by: { $0.current_price > $1.current_price }) {
            topCoins.append(coin)
            count += 1
            if count == 5 {
                break
            }
        }
        
        return topCoins
    }
    
    func downloadCoinData() {
        print("Size: \(coinManager.coins.count)")
        coinManager.$coins.sink {[weak self] coinData in
            self?.allCoins = coinData
        }.store(in: &cancellable)
    }
}
