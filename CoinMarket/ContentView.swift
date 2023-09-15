//
//  ContentView.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 08/09/2023.
//

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
