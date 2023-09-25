//
//  CircleButtonView.swift
//  CoinMarket
//
//  Created by Zoey on 18/09/2023.
//

/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Thai Thuan
  ID: s3877024
  Created  date: 17/09/2023
  Last modified: 17/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

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
