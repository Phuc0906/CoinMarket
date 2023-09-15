//
//  HomeView.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 10/09/2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @Environment(\.colorScheme) var colorScheme
    
    @State var coin: Coin
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                // MARK: Wallet
                VStack {
                    HStack {
                        Text("Home")
                            .font(.title)
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "dollarsign")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width / 20, height: UIScreen.main.bounds.width / 15)
                            Text("Your wallet")
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        
                        Text("123456 $")
                            .padding(EdgeInsets(top: 30, leading: 0, bottom: 20, trailing: 0))
                            .font(.title2)
                    }.padding(EdgeInsets(top: 30, leading: 25, bottom: 30, trailing: 30))
                        .foregroundColor(colorScheme == .dark ? .black : Color(UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1.00)))
                        .background(Color(UIColor(red: 1.00, green: 0.87, blue: 0.16, alpha: 1.00)))
                        .cornerRadius(20)
                }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .cornerRadius(20)
                
                //MARK: Functional button
                
                
                // MARK: Top 5 highest coins
                VStack {
                    VStack {
                        HStack {
                            Text("Top stock")
                            Spacer()
                            Text("See all")
                        }.padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    }
                    VStack {
//                        NavigationLink(destination: CoinDetailView(coin: coin)) {
//                            CoinRow(coin: coin)
//                        }
                        ForEach(vm.getTopCoins(), id: \.id) {coin in
                            NavigationLink(destination: CoinDetailView(coin: coin)) {
                                CoinRow(coin: coin)
                            }
                        }
                    }.padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    Spacer()
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(coin: dev.coin)
            .environmentObject(dev.homeVM)
            .preferredColorScheme(.light)
    }
}

struct HomeView_Previews_Dark: PreviewProvider {
    static var previews: some View {
        HomeView(coin: dev.coin)
            .environmentObject(dev.homeVM)
            .preferredColorScheme(.dark)
    }
}
