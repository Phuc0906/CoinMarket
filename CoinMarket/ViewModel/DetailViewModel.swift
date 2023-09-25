//
//  DetailViewModel.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 15/09/2023.
//

/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Hoang Phuc
  ID: s3879362
  Created  date: 15/09/2023
  Last modified: 15/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

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
