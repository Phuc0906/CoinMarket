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
    
    func changePassword(newPass: String){
        if let user = Auth.auth().currentUser{
            user.updatePassword(to: newPass) { error in
                if let error = error {
                    print("Error updating password.")
                } else {
                    print("Password update susscessfully.")
                }
            }
        } else {
            print("user in not signed in.")
        }
    }
    
    func getEmail() -> String? {
        if let currentUser = Auth.auth().currentUser {
            let userEmail = currentUser.email
            // Now, userEmail contains the user's email address
            return userEmail
        } else {
            // No user is signed in.
            return nil
        }
    }
}
