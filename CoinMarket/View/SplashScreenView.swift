//
//  SplashScreenView.swift
//  CoinMarket
//
//  Created by hhhh on 24/09/2023.
//

/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Le Tan Phong
  ID: s3877819
  Created  date: 17/09/2023
  Last modified: 17/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct SplashScreenView: View {
    @State var isActive : Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    // Customise your SplashScreen here
    var body: some View {
        if isActive {
            ContentView()
        } else {
            VStack {
                VStack {
                    Image("logo-app")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                        .foregroundColor(.red)
                    Text("Coin Market")
                        .font(Font.custom("WixMadeForDisplay-Bold", size: 26))
                        .foregroundColor(Color.theme.accent)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.00
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}


