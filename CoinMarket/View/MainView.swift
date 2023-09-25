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
    @StateObject private var vm = HomeViewModel()
    @StateObject private var cryptoVM = CryptoViewModel()
    
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                HomeView(selectedTab: $selectedTab , coin: DeveloperPreview.instance.coin)
                    .tabItem {
                        if !isShownAdd {
                            Image(systemName: "house.fill")
                        }
                            
                    }
                    .environmentObject(vm)
                    .tag(0)
                    
                CryptoView()
                    .tabItem {
                        if !isShownAdd {
                            Image(systemName: "chart.line.uptrend.xyaxis")
                        }
                        
                    }
                    .tag(1)
                    .environmentObject(cryptoVM)
                
                
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
                
                if isShownAdd {
                    selectedTab = lastSelectedTab
                    return
                }
                
                lastSelectedTab = (newValue == 9) ? lastSelectedTab : newValue
                
            }
            .animation(.easeInOut) // Apply animation to the entire TabView
            .transition(.slide)
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
