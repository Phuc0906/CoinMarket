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
                Text("\(coin.symbol)")
                    .textCase(.uppercase)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("$ \(String(format: "%.2f", coin.current_price))")
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                Text("\(String(format: "%.2f", coin.price_change_percentage_24h))")
                    .foregroundColor((coin.price_change_24h > 0) ? Color.green : Color.red)
                    
            }
        }.padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            .background(colorScheme == .dark ? .black : .white)
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
