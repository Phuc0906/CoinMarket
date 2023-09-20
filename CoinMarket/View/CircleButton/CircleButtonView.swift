//
//  CircleButtonView.swift
//  CoinMarket
//
//  Created by Zoey on 18/09/2023.
//

import SwiftUI

struct CircleButtonView: View {
    let iconName: String
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle().foregroundColor(Color.theme.background)
            )
            .shadow(color: Color.theme.accent.opacity(0.25), radius:10)
            .padding()
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleButtonView(iconName: "plus")
                .previewLayout(.sizeThatFits)
            CircleButtonView(iconName: "info")
                .previewLayout(.sizeThatFits)
                .colorScheme(.dark)
        }
    }
}
