//
//  CoinHoldingRow.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 20/09/2023.
//

/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Hoang Phuc
  ID: s3879362
  Created  date: 20/09/2023
  Last modified: 20/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct CoinHoldingRow: View {
    @Environment(\.colorScheme) var colorScheme
    
    let coin: Coin
    let transaction: Transaction
    
    var body: some View {
        HStack {
            HStack {
                Text("\(coin.market_cap_rank)")
                    .foregroundColor(Color.theme.secondaryText)
                    .font(.caption)
                    .frame(minWidth: 30)
                AsyncImage(url: URL(string: coin.image)) { phase in
                    switch phase {
                    case .empty:
                        // Placeholder view while the image is loading
                        ProgressView()
                    case .success(let image):
                        // Display the loaded image
                        image
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width / 8.5, height: UIScreen.main.bounds.width / 8.5)
                            .scaledToFit()
                            .cornerRadius(30)
                        
                    case .failure(let error):
                        // Handle the image loading failure
                        Text("Failed to load image: \(error.localizedDescription)")
                    @unknown default:
                        // Handle any future cases if added
                        Text("Unknown image loading error")
                    }
                }
                Text("\(coin.symbol.uppercased())")
                    .font(.headline)
                    .padding(.leading, 6)
                    .foregroundColor(Color.theme.accent)
                
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("Holding")
                    .foregroundColor(Color.theme.accent)
                Text("\(transaction.numberOfCoin)")
                    .foregroundColor((coin.price_change_24h > 0) ? Color.theme.green : Color.theme.red)
            }
        }.padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            .background(Color.theme.background)
            .cornerRadius(10)
    }
}

