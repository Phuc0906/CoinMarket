//
//  CoinDetailView.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 13/09/2023.
//

import SwiftUI

struct CoinDetailView: View {
    @State var coin: Coin
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                coinIntroduction
                
                briefRecord
                
                ChartView(coin: coin)
                    .frame(height: UIScreen.main.bounds.height / 2.7)
                
                HStack {
                    VStack {
                        Button {
                            // move to login page
                        } label: {
                            Text("Login")
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }

                    }.frame(width: UIScreen.main.bounds.width / 2)
                    .cornerRadius(20)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    
                }.background(.yellow)
                    .cornerRadius(30)
                    
                    
                
                Spacer()
            }.navigationTitle(
                Text("\(coin.name)")
            )
        }
    }
}

struct CoinDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CoinDetailView(coin: dev.coin)
    }
}

extension CoinDetailView {
    private var coinIntroduction: some View {
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
            Spacer()
            HStack {
                Text("\(String(format: "%.2f", coin.ath_change_percentage))")
                    .foregroundColor(.white)
                Image(systemName: coin.ath_change_percentage > 0 ? "chevron.up" : "chevron.down")
                    .foregroundColor(.white)
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 5))
            .background(.yellow)
            .cornerRadius(20)
            
        }.padding(EdgeInsets(top: 5, leading: 20, bottom: 10, trailing: 20))
    }
    
    private var briefRecord: some View {
        HStack(spacing: 40) {
            VStack(spacing: 10) {
                Text("High")
                    .foregroundColor(.gray)
                    .font(.title3)
                Text("$ \(String(format: "%.2f", coin.sparkline_in_7d.price.max() ?? 0))")
            }
            VStack(spacing: 10) {
                Text("Low")
                    .foregroundColor(.gray)
                    .font(.title3)
                Text("$ \(String(format: "%.2f", coin.sparkline_in_7d.price.min() ?? 0))")
            }
            VStack(spacing: 10) {
                Text("High")
                    .foregroundColor(.gray)
                    .font(.title3)
                Text("$ \(String(format: "%.2f", ((coin.sparkline_in_7d.price.max() ?? 0) + (coin.sparkline_in_7d.price.min() ?? 0)) / 2 ))")
            }
        }.padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
    }
}
