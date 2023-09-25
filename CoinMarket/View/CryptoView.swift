//
//  CryptoView.swift
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

struct CryptoView: View {
    
    @EnvironmentObject private var vm: CryptoViewModel
    @StateObject private var detailVM = DetailViewModel()
    @State var query = ""
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                // MARK: Wallet
                VStack {
                    HStack {
                        Text("Market")
                            .font(.title)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .fontWeight(.bold)
                        Spacer()
                    }
                }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .cornerRadius(20)
                
                //MARK: Functional button
                VStack {
                    VStack {
                        ForEach(vm.filterCoins, id: \.id) {coin in
                            NavigationLink(destination: CoinDetailView(coin: coin).environmentObject(detailVM)) {
                                CoinRow(coin: coin)
                            }
                        }
                    }.padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    Spacer()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .searchable(text: $query).onChange(of: query) { newValue in
            vm.getFilterCoin(query: newValue)
        }
    }
}

struct CryptoView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoView()
    }
}
