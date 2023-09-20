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
    
    
}
