//
//  Transaction.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 18/09/2023.
//

/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Hoang Phuc
  ID: s3879362
  Created  date: 18/09/2023
  Last modified: 18/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import Foundation

struct Transaction: Identifiable, Codable {
    let id = UUID()
    let coinId: String
    let userId: String
    var amount: Double
    var numberOfCoin: Double
    let transactionDate: Date
    
    init(coinId: String, userId: String, amount: Double, currentPrice: Double, transactionDate: Date) {
        self.coinId = coinId
        self.userId = userId
        self.amount = amount
        self.numberOfCoin = amount / currentPrice
        self.transactionDate = transactionDate
    }
    
    init(coinId: String, userId: String, amount: Double, numberOfCoin: Double, transactionDate: Date) {
        self.coinId = coinId
        self.userId = userId
        self.amount = amount
        self.numberOfCoin = numberOfCoin
        self.transactionDate = transactionDate
    }
    
    init(coinId: String, userId: String, currentPrice: Double, numberOfCoin: Double, transactionDate: Date) {
        self.coinId = coinId
        self.userId = userId
        self.amount = currentPrice*numberOfCoin*(-1)
        self.numberOfCoin = numberOfCoin
        self.transactionDate = transactionDate
    }
}
