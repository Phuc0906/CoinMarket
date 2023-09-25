//
//  WalletView.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 10/09/2023.
//
import SwiftUI
import Charts


struct WalletView: View {
    //MARK: PROPERTIES
    @StateObject private var transferVM = TransferViewModel()
    @State private var showPortfolio = false
    @State private var showInfo = false
    @State private var showTransfer = false
    @State private var isDeposit = false
    @State var selectedPie: String = ""
    @State var selectedDonut: String = ""
    @ObservedObject private var userManager = UserManager()
    let coinManager = CoinManager()
    
    //MARK: BODY
    var body: some View {
        VStack {
            //MARK: HEADING TITLE
            HStack {
                CircleButtonView(iconName: "info")
                    .background(
                        CircleButtonAnimationView(animate: $showPortfolio)
                    )
                    .onTapGesture {
                        showInfo = true
                    }
                    
                Spacer()
                Text(!showPortfolio ? "Balance" : "Portfolio")
                    .font(.headline)
                    .foregroundColor(Color.theme.accent)
                    .animation(.none, value: showPortfolio)
                Spacer()
                CircleButtonView(iconName: "chevron.right")
                    .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                    .onTapGesture {
                        withAnimation(.spring()) {
                            showPortfolio.toggle()
                        }
                    }
            }
            if (showPortfolio) {
                portfolioSection
            } else {
                balanceSection
            }
            Spacer()
        }
        .fullScreenCover(isPresented: $showTransfer) {
            TransferView().environmentObject(transferVM)
        }
        
        .sheet(isPresented:$isDeposit) {
            DepositView()
        }
        .onChange(of: isDeposit){newValue in
            userManager.getUserInfo {
                print("Get user updated balance: \(userManager.userInfo?.balance ?? "FAIL")")
            }
        }
    }
}

extension WalletView {
    //MARK: PORTFOLIO VIEW
    private var portfolioSection: some View {
        VStack {
            if let holdings = userManager.holdings {
                PieChart(dataModel: holdings) {  dataModel in
                    if let dataModel = dataModel {
                        let percentage = String(format: "%.2f", (dataModel.amount / holdings.totalValue)*100)
                        self.selectedPie = "\(dataModel.name) achieves \(percentage)% of the total spots"
                    } else {
                        self.selectedPie = ""
                    }
                }
                .frame(width: UIScreen.main.bounds.width/1.5, height:  UIScreen.main.bounds.height/5)
                
                Text("\(selectedPie)")
            }
            
            
            List {
                Section("Holding List") {
                    HStack {
                        Text("Rank")
                            .font(.caption)
                            .foregroundColor(Color.theme.secondaryText)
                        Text("Name")
                            .font(.caption)
                            .foregroundColor(Color.theme.secondaryText)
                            .padding(.leading, 10)
                        Spacer()
                        Text("Total Coin Value")
                            .font(.caption)
                            .foregroundColor(Color.theme.secondaryText)
                    }
                    .padding()
                    ForEach(Array(userManager.wallet.keys.sorted()), id: \.self) { coinId in
                        if let transaction = userManager.wallet[coinId], let currentCoin = coinManager.getCoin(coinId: transaction.coinId) {
                            WalletCoinRow(transaction: transaction, coin: currentCoin)
                                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                    Button(role: .destructive) {
                                        // Perform the delete action here
                                        userManager.sellAll(coinID: coinId)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                    }
                }
                
            }
            .padding(.vertical)
            .listStyle(GroupedListStyle())
        }
    }
    
    //MARK: BALANCE VIEW
    private var balanceSection: some View {
        VStack(spacing: 30) {
            //MARK: BALANCE
            VStack {
                if let user = userManager.userInfo {
                    let myDouble = Double(user.balance)?.formattedWithAbbreviations()
                    Text(myDouble ?? "")
                        .font(.system(size: 50))
                        .foregroundColor(Color.theme.accent)
                } else {
                    Text("0$")
                        .font(.system(size: 50))
                        .foregroundColor(Color.theme.accent)
                }
                Text("Total Balance")
                    .font(.caption)
                    .foregroundColor(Color.theme.accent)
            }
            HStack {
                Spacer()
                //MARK: DEPOSIT BUTTON
                Button(action: {
                    isDeposit.toggle()
                }) {
                    VStack {
                        Image(systemName: "dollarsign.arrow.circlepath")
                            .foregroundColor(.white)
                        Text("Deposit")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: 200)
                    }
                    .padding()
                    .background(
                        Capsule()
                            .fill(Color.yellow) // Change the color to your desired background color
                    )
                }
                
                Spacer()
                
                //MARK: TRANSFER BUTTON
                Button(action: {
                  showTransfer = true
                }) {
                    
                    VStack {
                        Image(systemName: "person.line.dotted.person")
                            .foregroundColor(.white)
                        Text("P2P Trading")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: 200)
                    }
                    .padding()
                    .background(
                        Capsule()
                            .fill(Color.yellow) // Change the color to your desired background color
                    )
                }
                Spacer()
                
            }
            
            //MARK: ASSETS
            VStack {
                ZStack {
                    if let userAssets = userManager.userAssets {
                        PieChart(dataModel: userAssets) { dataModel in
                            if let dataModel = dataModel {
                                let percentage = String(format: "%.2f",
                                                        (dataModel.amount/userAssets.totalValue)*100)
                                self.selectedPie = "\(dataModel.name) achieves \(percentage)% of the total assets"
                            }else {
                                self.selectedPie = ""
                            }
                            
                        }
                    }
                    Circle()
                        .foregroundColor(Color.theme.background)
                        .frame(width: UIScreen.main.bounds.width/1.5)
                    
                    Text("\(selectedPie)")
                        .frame(width: UIScreen.main.bounds.width/2)
                        .multilineTextAlignment(.center)
                    
                }
                .padding()
            }
        }
        .sheet(isPresented: $showInfo) {
            InfoView()
        }
    }
}
