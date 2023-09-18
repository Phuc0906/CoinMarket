//
//  Transaction.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 18/09/2023.
//

import Foundation

struct Transaction: Identifiable, Codable {
    let id = UUID()
    let coinId: String
    let userId: String
    let amount: Double
    let numberOfCoin: Double
    let transactionDate: Date
    
    init(coinId: String, userId: String, amount: Double, currentPrice: Double, transactionDate: Date) {
        self.coinId = coinId
        self.userId = userId
        self.amount = amount
        self.numberOfCoin = amount / currentPrice
        self.transactionDate = transactionDate
    }
}
