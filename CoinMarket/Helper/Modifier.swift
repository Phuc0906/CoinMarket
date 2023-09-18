//
//  Modifier.swift
//  CoinMarket
//
//  Created by hhhh on 17/09/2023.
//

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
