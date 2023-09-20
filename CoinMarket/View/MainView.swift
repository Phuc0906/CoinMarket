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
                    
                
                AddButtonCustomView(lastSelectedTab: $lastSelectedTab, selectedTab: $selectedTab)
                    .tag(9)
                
                
                WalletView(holdings: ChartDataModel.init(dataModel: [ChartCellModel(color: .orange, name:"Bitcoin", amount: 3.5), ChartCellModel(color: .red, name: "Dodge", amount: 7)]), userAssets: ChartDataModel.init(dataModel: [ChartCellModel(color: .purple, name: "Cash", amount: 10000), ChartCellModel(color: .pink, name: "Coins Value", amount: 50000)]))
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
            
            VStack {
                Spacer()
                AddCoinView(isShown: $isShownAdd)
            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
            
            VStack {
                Spacer()
                Button(action: {
                    isShownAdd.toggle()
                }) {
                    Image(systemName: "plus")
                        .rotationEffect(isShownAdd ? Angle(degrees: 45) : Angle(degrees: 0))
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
