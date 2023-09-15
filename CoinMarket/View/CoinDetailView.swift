//
//  CoinDetailView.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 13/09/2023.
//

import SwiftUI
import Firebase

struct CoinDetailView: View {
    @EnvironmentObject private var vm: DetailViewModel
    @State var coin: Coin
    @State private var toLogin = false
    @State private var toBuyView = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 15) {
                    
                        
                    coinIntroduction
                    briefRecord
                    ChartView(coin: coin)
                        .frame(height: UIScreen.main.bounds.height / 2.7)
                    
                    functionalButton
                }
            }.navigationTitle(Text("\(coin.name)"))
        }.fullScreenCover(isPresented: $toLogin) {
            LoginView()
        }.fullScreenCover(isPresented: $toBuyView) {
            BuyView(coin: coin)
        }
    }
}

//struct CoinDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        CoinDetailView(coin: dev.coin)
//    }
//}

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
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                Image(systemName: coin.ath_change_percentage > 0 ? "chevron.up" : "chevron.down")
                    .foregroundColor(colorScheme == .dark ? .black : .white)
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
    
    private var functionalButton: some View {
        VStack {
            if let user = vm.user {
                HStack {
                    HStack {
                        VStack {
                            Button {
                                // MARK: move to sell page
                            } label: {
                                Text("Sell")
                                    .foregroundColor(colorScheme == .dark ? .black : .white)
                                    .cornerRadius(20)
                            }
                            
                        }.frame(width: UIScreen.main.bounds.width / 3)
                            .cornerRadius(20)
                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    }.background(.yellow)
                    .cornerRadius(30)
                    Spacer()
                    HStack {
                        VStack {
                            Button {
                                // MARK: move to buy page
                                toBuyView = true
                            } label: {
                                Text("Buy")
                                    .foregroundColor(colorScheme == .dark ? .black : .white)
                                    .cornerRadius(20)
                            }
                            
                        }.frame(width: UIScreen.main.bounds.width / 3)
                            .cornerRadius(20)
                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    }.background(.yellow)
                    .cornerRadius(30)
                }.padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
            }else {
                HStack {
                    VStack {
                        Button {
                            // move to login page
                            toLogin = true
                        } label: {
                            Text("Login")
                                .foregroundColor(colorScheme == .dark ? .black : .white)
                                .cornerRadius(20)
                        }
                        
                    }.frame(width: UIScreen.main.bounds.width / 2)
                        .cornerRadius(20)
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                }.background(.yellow)
                    .cornerRadius(30)
            }
        }
    }
}
