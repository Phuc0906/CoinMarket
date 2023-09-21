//
//  CoinViewModel.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 18/09/2023.
//

import Foundation
import Firebase
import FirebaseAuth

struct UserInfo: Identifiable, Codable {
    var id: String
    var name: String
    var balance: String
}


class BuyViewModel: ObservableObject {
    private var auth = AuthViewModel()
    let db = Firestore.firestore()
    let userManager = UserManager()
    let coinManager = CoinManager()
    
    func getCoin(coinId: String) -> Coin {
        return coinManager.getCoin(coinId: coinId)!
    }
    
    func buy(transaction: Transaction) {
        userManager.addTransaction(transaction: transaction)
    }
    
    func isUserHasCoin(coinID: String) -> Bool {
        return userManager.isHadCoin(coinID: coinID)
    }
    
    func getUserHolding(coinID: String) -> Double {
        return userManager.getUserHolding(coinID: coinID)
    }
    
    func sell(transaction: Transaction) {
        userManager.sell(transaction: transaction)
    }
    
}
