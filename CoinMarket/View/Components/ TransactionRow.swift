//
//  TransactionRow.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 23/09/2023.
//

import SwiftUI

struct TransactionRow: View {
    @Environment(\.colorScheme) var colorScheme
    
    let coin: Coin
    let transaction: Transaction
    
    var body: some View {
        HStack {
            HStack {
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
                
                if transaction.amount < 0 {
                    Image(systemName: "arrow.up.right")
                        .foregroundColor(.red)
                }else {
                    Image(systemName: "arrow.down.backward")
                        .foregroundColor(.green)
                }
                
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("\(transaction.numberOfCoin) \(coin.symbol.uppercased())")
                    .foregroundColor(Color.theme.accent)
                Text("$ \(transaction.amount.formattedWithAbbreviations())")
                    .foregroundColor((transaction.numberOfCoin > 0) ? Color.theme.green : Color.theme.red)
                
            }
        }.padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            .background(Color.theme.background)
            .cornerRadius(10)
        
    }
}

