//
//  ReceiverCodeInputViewModel.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 20/09/2023.
//

import Foundation
import Firebase

class ReceiverInputViewModel: ObservableObject {
    private var auth = AuthViewModel()
    let db = Firestore.firestore()
    let userManager = UserManager()
    
    func verifyUser(userId: String, verifyResult: @escaping (Bool) -> Void) {
        userManager.verifyUser(userId: userId) { result in
            verifyResult(result)
        }
    }
}
