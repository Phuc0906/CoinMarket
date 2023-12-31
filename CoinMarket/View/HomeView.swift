//
//  HomeView.swift
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

struct HomeView: View {
    @ObservedObject private var userManager = UserManager()
    @EnvironmentObject private var uVm: UserManager
    @Binding var selectedTab: Int
    @EnvironmentObject private var vm: HomeViewModel
    @Environment(\.colorScheme) var colorScheme
    
    @State var coin: Coin
    @StateObject private var detailVM = DetailViewModel()
    @StateObject private var transferVM = TransferViewModel()
    
    
    @State private var toTransferView = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                // MARK: Wallet
                VStack {
                    HStack {
                        Text(uVm.language ? "Home" : "Trang chủ")
                            .font(.custom("WixMadeForDisplay-ExtraBold", size: UIDevice.isIPhone ? 40 : 50))
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .fontWeight(.bold)
                        Spacer()
                        
                        Button {
                            // to transfer view
                            toTransferView = true
                        } label: {
                            Image(systemName: "qrcode.viewfinder")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIDevice.isIPhone ? 40 : 50)
                        }

                        
                        
                        
                    }
                    if let user = userManager.userInfo{
                        HStack{
                            VStack(alignment: .leading) {
                                Text(uVm.language ? "Your wallet" : "Ví của bạn")
                                    .modifier(TitleModifier())
                                let myDouble = Double(user.balance)?.formattedWithAbbreviations()
                                Text(myDouble ?? "")
                                    .modifier(TextModifier())
//
//                                Text("\(user.balance)$")
//                                    .modifier(TextModifier())
                            }
                            Spacer()
                        }
                        .padding(EdgeInsets(top: 30, leading: UIDevice.isIPhone ? 25 : 30, bottom: 30, trailing: 30))
                            .foregroundColor(Color.theme.accent)
                            .background(Color(UIColor(red: 1.00, green: 0.87, blue: 0.16, alpha: 1.00)))
                            .cornerRadius(20)
                        
                    }
                }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .cornerRadius(20)
                
                //MARK: Functional button
                
                
                // MARK: Top 5 highest coins
                VStack {
                    VStack {
                        HStack {
                            Text(uVm.language ? "Top stock" : "Phổ biến")
                            Spacer()
                            Text(uVm.language ? "See all" : "Tất cả")
                                .onTapGesture {
                                    selectedTab = 1
                                }
                        }.padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    }
                    VStack {
                        ForEach(vm.getTopCoins(), id: \.id) {coin in
                            NavigationLink(destination: CoinDetailView(coin: coin).environmentObject(detailVM)) {
                                CoinRow(coin: coin)
                            }
                        }
                    }.padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    Spacer()
                }.fullScreenCover(isPresented: $toTransferView) {
                    TransferView()
                        .environmentObject(transferVM)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(coin: dev.coin)
//            .environmentObject(dev.homeVM)
//            .preferredColorScheme(.light)
//    }
//}
//
//struct HomeView_Previews_Dark: PreviewProvider {
//    static var previews: some View {
//        HomeView(coin: dev.coin)
//            .environmentObject(dev.homeVM)
//            .preferredColorScheme(.dark)
//    }
//}
