//
//  AuthViewModel.swift
//  CoinMarket
//
//  Created by Anh Nguyễn on 15/09/2023.
//

import SwiftUI
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var user: User?
    
    init() {
        Auth.auth().addStateDidChangeListener { auth, user in
            self.user = user
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
