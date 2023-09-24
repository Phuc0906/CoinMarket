//
//  BuyHistoryViewModel.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 23/09/2023.
//

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
    
    func getUserBuyHistory() {
        
        if let user = auth.user {
            self.db.collection("buy_history").document("\(user.uid)").getDocument { (document, error) in
                
                if let document = document, document.exists {
                    
                    let dataTransactions = document.data()?.values.map(String.init(describing:))
                    
                    if let jsonData = dataTransactions![0].data(using: .utf8) {
                        do {
                            let transactions = try JSONDecoder().decode([Transaction].self, from: jsonData)
                            self.buyHistory = transactions
                            print("In buy his vm trans")
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
