//
//  TransferViewModel.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 20/09/2023.
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
    
    func verifyUser(userId: String, verifyResult: @escaping (Bool) -> Void) {
        userManager.verifyUser(userId: userId) { result in
            verifyResult(result)
        }
    }
}
