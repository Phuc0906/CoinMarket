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
