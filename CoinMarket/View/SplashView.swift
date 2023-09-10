//
//  SplashView.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 10/09/2023.
//

import SwiftUI

struct SplashView: View {
    @State var nextView: Bool = false
    var body: some View {
        ZStack {
            Color(UIColor(red: 1.00, green: 0.87, blue: 0.16, alpha: 1.00))
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Text("CRYPTO TRADING")
                    .font(.title)
                Text("Start trading now with Coin Market")
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20))
                    .foregroundColor(.gray)
                Spacer()
                VStack(spacing: 30) {
                    Button(action: {
                        
                    }) {
                        Text("Register Now")
                            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                            .font(.title2)
                            .background(.white)
                            .cornerRadius(30)
                    }
                    Button(action: {
                        nextView = true
                    }) {
                        HStack {
                            Text("Get start")
                                .font(.title2)
                                
                            Image(systemName: "arrow.right")
                                .foregroundColor(.black)
                        }.padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                            .background(.white)
                            .cornerRadius(30)
                    }
                }
                Spacer()
            }
            .padding()
        }.fullScreenCover(isPresented: $nextView) {
            MainView()
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
