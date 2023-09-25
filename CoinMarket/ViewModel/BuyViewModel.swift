//
//  CoinViewModel.swift
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
import Firebase
import FirebaseAuth

class BuyViewModel: ObservableObject {
    private var auth = AuthViewModel()
    let db = Firestore.firestore()
    let userManager = UserManager()
    let coinManager = CoinManager()
    
    func getCoin(coinId: String) -> Coin {
        return coinManager.getCoin(coinId: coinId)!
    }
    
    func buy(transaction: Transaction, complete: (() -> Void)? = nil) {
        userManager.addTransaction(transaction: transaction) {
            complete?()
        }
    }
    
    func isUserHasCoin(coinID: String) -> Bool {
        return userManager.isHadCoin(coinID: coinID)
    }
    
    func getUserHolding(coinID: String) -> Double {
        return userManager.getUserHolding(coinID: coinID, userWallet: userManager.wallet)
    }
    
    func sell(transaction: Transaction, complete: (() -> Void)? = nil) {
        userManager.sell(transaction: transaction) {
            complete?()
        }
    }
    
}
