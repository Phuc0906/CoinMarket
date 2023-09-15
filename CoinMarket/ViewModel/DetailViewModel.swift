//
//  DetailViewModel.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 15/09/2023.
//

import Foundation
import Firebase

class DetailViewModel:ObservableObject {
    @Published var user: User?
    
    init() {
        print("In here")
        Auth.auth().addStateDidChangeListener { auth, user in
            self.user = user
            print(user?.email)
        }
    }
}
