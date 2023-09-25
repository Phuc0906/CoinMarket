//
//  CircleAnimationButtonView.swift
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
  Created  date: 18/09/2023
  Last modified: 18/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/


import SwiftUI

struct CircleButtonAnimationView: View {
    @Binding var animate: Bool
    var body: some View {
        Circle()
           .stroke(lineWidth: 5)
           .scaleEffect(animate ? 1.0 : 0.0)
           .opacity(animate ? 0.0 : 1.0)
           .animation(animate ? .easeInOut(duration: 1.0) : .none, value: animate)
    }
}

struct CircleButtonAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonAnimationView(animate: Binding.constant(false))
            .foregroundColor(.red)
            .frame(width: 100, height: 100)
    }
}
