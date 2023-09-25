//
//  CryptoViewModel.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 14/09/2023.
//

/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Hoang Phuc
  ID: s3879362
  Created  date: 14/09/2023
  Last modified: 14/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

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
