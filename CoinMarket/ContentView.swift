//
//  ContentView.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 08/09/2023.
//

/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Hoang Phuc
  ID: s3879362
  Created  date: 8/09/2023
  Last modified: 8/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI


struct ContentView: View {
    @StateObject var authViewModel = AuthViewModel()
    var body: some View {
        if let user = authViewModel.user {
            MainView()
        } else {
            SplashView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
