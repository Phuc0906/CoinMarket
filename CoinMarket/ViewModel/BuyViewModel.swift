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
    var userInfo: UserInfo?
    let userManager = UserManager()
    

    
    func buy(transaction: Transaction) {
        userManager.addTransaction(transaction: transaction)
    }
    
}
