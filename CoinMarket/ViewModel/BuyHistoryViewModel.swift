//
//  BuyHistoryViewModel.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 23/09/2023.
//

/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Hoang Phuc
  ID: s3879362
  Created  date: 20/09/2023
  Last modified: 20/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import Foundation
import Firebase

class BuyHistoryViewModel: ObservableObject {
    private var auth = AuthViewModel()
    let db = Firestore.firestore()
    let userManager = UserManager()
    let coinManager = CoinManager()
    @Published var buyHistory: [Transaction] = []
    
    init() {
        print("In buy his vm init")
        Auth.auth().addStateDidChangeListener { auth, user in
            print("Authrozied")
            self.getUserBuyHistory()
        }
        
    }
    
    // MARK: fetch user buy history
    func getUserBuyHistory() {
        
        if let user = auth.user {
            self.db.collection("buy_history").document("\(user.uid)").getDocument { (document, error) in
                
                if let document = document, document.exists {
                    
                    let dataTransactions = document.data()?.values.map(String.init(describing:))
                    
                    if let jsonData = dataTransactions![0].data(using: .utf8) {
                        do {
                            let transactions = try JSONDecoder().decode([Transaction].self, from: jsonData)
                            self.buyHistory = transactions
                        }catch {
                            
                        }
                    }
                }
            }
        }
        
    }
    
    func getCoin(transaction: Transaction) -> Coin {
        return coinManager.getCoin(coinId: transaction.coinId)!
    }
}
