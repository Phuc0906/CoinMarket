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
    
    func transfer(amount: Double, selectedTransaction: Transaction, receiverID: String) {
        print("Transfer complete")
        userManager.saveTransaction(transaction: selectedTransaction, coins: coinManager.coins)
        userManager.addBuyHistory(transaction: Transaction(coinId: selectedTransaction.coinId, userId: selectedTransaction.userId, amount: 0, numberOfCoin: amount*(-1), transactionDate: Date()))
        userManager.transferTo(receiverID: receiverID, transaction: Transaction(coinId: selectedTransaction.coinId, userId: selectedTransaction.userId, amount: 0, numberOfCoin: amount, transactionDate: Date()), coins: coinManager.coins)
    }
}
