//
//  UserManager.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 18/09/2023.
//

import Foundation
import Firebase

class UserManager {
    @Published var transactions: [Transaction] = []
    private var auth = AuthViewModel()
    let db = Firestore.firestore()
    
    func addTransaction(transaction: Transaction) {
        transactions.append(transaction)
        do {
            let encodedData = try JSONEncoder().encode(transactions)
            let jsonString = String(data: encodedData,
                                    encoding: .utf8)
            if let user = auth.user {
                db.collection("transactions").document("\(user.uid)").setData(["list_of_transaction": jsonString!]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document transaction written!")
                    }
                }
            }
        }catch {
            
        }
    }
}
