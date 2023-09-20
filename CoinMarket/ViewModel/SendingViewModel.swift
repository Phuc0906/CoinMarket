//
//  SendingViewViewModel.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 20/09/2023.
//

import Foundation
import Firebase

class SendingViewModel: ObservableObject {
    private var auth = AuthViewModel()
    let db = Firestore.firestore()
    let userManager = UserManager()
    let coinManager = CoinManager()
    @Published var userWallet: [Transaction] = []
    
    func getCoin(coinId: String) -> Coin {
        return coinManager.getCoin(coinId: coinId)!
    }
    
    func transfer(amount: Double, selectedTransaction: Transaction) {
        var processAmount = amount * -1
        var userTransactions = userManager.transactions
        
        var i = 0
        while i < userTransactions.count {
            if userTransactions[i].coinId == selectedTransaction.coinId {
                let tmpCoinAmount = processAmount
                processAmount += userTransactions[i].numberOfCoin
                if userTransactions[i].numberOfCoin <= abs(tmpCoinAmount) {
                    userTransactions[i].numberOfCoin = 0
                }else {
                    userTransactions[i].numberOfCoin -= tmpCoinAmount
                    print("Current trans")
                    print(userTransactions[i])
                }
                print(processAmount)
                if processAmount >= 0 {
                    
                    break
                }
            }
            i += 1
        }
        
        print("Transfer complete")
        print(userTransactions)
        userManager.saveTransaction(transactions: userTransactions)
        
        
    }
}
