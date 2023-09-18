//
//  CoinViewModel.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 18/09/2023.
//

import Foundation
import Firebase

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
    
    func getUserInfo() {
        if let user = auth.user {
            
            db.collection("users").document("\(user.uid)").getDocument { document, error in
                if let document = document, document.exists {
                    let userData = document.data()?.values.map(String.init(describing:))
                    if let jsonData = userData![0].data(using: .utf8) {
                        do {
                            let userObject = try JSONDecoder().decode(UserInfo.self, from: jsonData)
                            self.userInfo = userObject
                        }catch {

                        }
                    }
                }
            }
        }
    }
    
    func buy(transaction: Transaction) {
        userManager.addTransaction(transaction: transaction)
    }
    
}
