//
//  CoinRow.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 12/09/2023.
//

import SwiftUI

struct CoinRow: View {
    @Environment(\.colorScheme) var colorScheme
    
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
                Text("$ \(String(format: "%.2f", coin.current_price))")
                    .foregroundColor(Color.theme.accent)
                Text("\(String(format: "%.2f", coin.price_change_percentage_24h))")
                    .foregroundColor((coin.price_change_24h > 0) ? Color.theme.green : Color.theme.red)
                
            }
        }.padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            .background(Color.theme.background)
            .cornerRadius(10)
        
    }
}

struct CoinRow_Previews: PreviewProvider {
    static var previews: some View {
        CoinRow(coin: dev.coin)
            .preferredColorScheme(.light)
    }
}

struct CoinRow_Previews_dark: PreviewProvider {
    static var previews: some View {
        CoinRow(coin: dev.coin)
            .preferredColorScheme(.dark)
    }
}
