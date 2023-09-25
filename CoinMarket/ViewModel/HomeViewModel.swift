//
//  HomeViewModel.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 12/09/2023.
//

/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Hoang Phuc
  ID: s3879362
  Created  date: 12/09/2023
  Last modified: 12/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var allCoins: [Coin] = []
    
    private let coinManager = CoinManager()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        downloadCoinData()
    }
    
    // MARK: mark and sort to get top 5 coins
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
    
    // MARK: get all coins from database
    func downloadCoinData() {
        print("Size: \(coinManager.coins.count)")
        coinManager.$coins.sink {[weak self] coinData in
            self?.allCoins = coinData
        }.store(in: &cancellable)
    }
}
