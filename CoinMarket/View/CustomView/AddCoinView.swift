//
//  AddCoinView.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 10/09/2023.
//

/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Hoang Phuc
  ID: s3879362
  Created  date: 10/09/2023
  Last modified: 10/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct AddCoinView: View {
    @Binding var isShown: Bool
    @State private var isDisplay = false
    
    var body: some View {
        HStack {
            
            if isShown {
                Image(systemName: "plus.circle")
                Text("Buy")
                    .font(.title3)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: isShown ? 20 : 0)
        .padding(isShown ? EdgeInsets(top: 20, leading: 25, bottom: 20, trailing: 30) : EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .shadow(radius: 20)
        .background(.yellow)
        .cornerRadius(radius: 20, corner: .topLeft)
        .cornerRadius(radius: 20, corner: .topRight)
        
    }
}


struct RoundedCornerCustom: Shape {
    var radius: CGFloat
    var corner: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path: UIBezierPath = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
    
    
}

extension View {
    func cornerRadius(radius: CGFloat, corner: UIRectCorner) -> some View {
        clipShape(RoundedCornerCustom(radius: radius, corner: corner))
    }
}
