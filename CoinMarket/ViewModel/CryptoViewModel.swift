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
    
    private let coinManager = CoinManager()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        downloadCoinData()
    }
    
    func downloadCoinData() {
        print("Size: \(coinManager.coins.count)")
        coinManager.$coins.sink {[weak self] coinData in
            self?.allCoins = coinData
        }.store(in: &cancellable)
    }
}
