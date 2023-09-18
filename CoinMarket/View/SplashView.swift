//
//  SplashView.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 10/09/2023.
//

import SwiftUI

struct SplashView: View {
    @State var nextView: Bool = false
    @State var registerView: Bool = false
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
                LoginView(nextView: $nextView, RegisterView: $registerView)
                
        }.fullScreenCover(isPresented: $nextView) {
            MainView()
        }
        .fullScreenCover(isPresented: $registerView) {
            RegisterView()
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
            .previewDisplayName("iPhone 14 Pro Max")
        
        SplashView()
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch)"))
            .previewDisplayName("iPad Pro")
    }
}
