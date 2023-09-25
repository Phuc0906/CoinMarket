//
//  WalletCoinRow.swift
//  CoinMarket
//
//  Created by Anh Nguyễn on 21/09/2023.
//\

/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Nguyen Hung Anh
  ID: s3877798
  Created  date: 21/09/2023
  Last modified: 21/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct WalletCoinRow: View {
    
    let coinManager = CoinManager()
    let transaction: Transaction
    let coin: Coin
   
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
                let currentHoldingVal = coin.current_price * transaction.numberOfCoin
                Text("$ \(String(format: "%.2f", currentHoldingVal))")
                    .foregroundColor(Color.theme.accent)
                Text("Quantity: \(String(format: "%.1f", transaction.numberOfCoin))")
                    .font(.caption)
                    .foregroundColor(Color.theme.secondaryText)
                
            }
        }.padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            .background(Color.theme.background)
            .cornerRadius(10)
            .onAppear{
                print(transaction.coinId)
            }
    }
}

