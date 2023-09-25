//
//  Modifier.swift
//  CoinMarket
//
//  Created by hhhh on 17/09/2023.
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


struct TextFieldModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(UIDevice.isIPhone ? .title3 : .largeTitle)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color("TextField"))
            .foregroundColor(Color("Placeholder"))
            .cornerRadius(10)
    }
}

struct TitleModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.custom("WixMadeforDisplay-ExtraBold", size: UIDevice.isIPhone ? 30 : 40))
    }
}

struct TextModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.custom("WixMadeforDisplay-Medium", size: UIDevice.isIPhone ? 20 : 35))
    }
}

struct MediumButton: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.custom("WixMadeforDisplay-Medium", size: UIDevice.isIPhone ? 20 : 30))
            .frame(maxWidth: .infinity)
            .frame(height: UIDevice.isIPhone ? 40 : 60)
            .background(Color("TextField"))
            .foregroundColor(.black)
            .cornerRadius(20)
    }
}

struct LongButton: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 25 : 40))
            .frame(maxWidth: .infinity)
            .frame(height: UIDevice.isIPhone ? 50 : 70)
            .background(.yellow)
            .foregroundColor(Color.theme.background)
            .cornerRadius(10)
    }
}

struct SignOutButton: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 25 : 40))
            .frame(maxWidth: .infinity)
            .frame(height: UIDevice.isIPhone ? 50 : 70)
            .background(Color("Logout"))
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}
