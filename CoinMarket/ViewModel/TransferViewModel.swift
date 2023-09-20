//
//  TransferViewModel.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 20/09/2023.
//

import Foundation
import Firebase

class TransferViewModel: ObservableObject {
    private var auth = AuthViewModel()
    let db = Firestore.firestore()
    let userManager = UserManager()
    
    func getUserId() -> String {
        if let user = auth.user {
            return user.uid
        }
        
        return ""
    }
    
    func getUserName() -> String {
        if let user = userManager.userInfo {
            return user.name
        }
        return ""
    }
}
