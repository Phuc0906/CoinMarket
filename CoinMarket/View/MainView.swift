//
//  MainView.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 10/09/2023.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab = 0
    @State private var lastSelectedTab = 0
    @State private var isShownAdd: Bool = false
    
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        if !isShownAdd {
                            Image(systemName: "house.fill")
                        }
                            
                    }
                    .tag(0)
                    
                CryptoView()
                    .tabItem {
                        if !isShownAdd {
                            Image(systemName: "chart.line.uptrend.xyaxis")
                        }
                        
                    }
                    .tag(1)
                    .onTapGesture {
                        print("Helo crypto")
                    }
                
                AddButtonCustomView(lastSelectedTab: $lastSelectedTab, selectedTab: $selectedTab)
                    .tag(9)
                
                
                WalletView()
                    .tabItem {
                        if !isShownAdd {
                            Image(systemName: "wallet.pass")
                        }
                        
                    }
                    .tag(2)
                
                ProfileView()
                    .tabItem {
                        if !isShownAdd {
                            Image(systemName: "person.circle")
                        }
                        
                    }
                    .tag(3)
            }
            .onChange(of: selectedTab) { newValue in
                print("Detect \(newValue)")
                lastSelectedTab = (newValue == 9) ? lastSelectedTab : newValue
                
                print("Selected Tab: \(newValue)")
                print("Show: \(isShownAdd)")
            }
            
            VStack {
                Spacer()
                AddCoinView(isShown: $isShownAdd)
            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 60, trailing: 0))
            
            VStack {
                Spacer()
                Button(action: {
                    isShownAdd.toggle()
                }) {
                    Image(systemName: "plus")
                        .padding(EdgeInsets(top: 7, leading: 7, bottom: 7, trailing: 7))
                        .background(.yellow)
                        .cornerRadius(30)
                }
            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
