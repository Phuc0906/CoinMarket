//
//  WalletView.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 10/09/2023.
//
import SwiftUI
import Charts


struct WalletView: View {
    @State private var showPortfolio = false
    @State var selectedPie: String = ""
    @State var selectedDonut: String = ""
    let holdings: ChartDataModel
    let userAssets: ChartDataModel
    var body: some View {
        VStack {
            HStack {
                CircleButtonView(iconName: "info")
                    .background(
                        CircleButtonAnimationView(animate: $showPortfolio)
                    )
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
                VStack {
                    PieChart(dataModel: holdings) {  dataModel in
                        if let dataModel = dataModel {
                            let percentage = String(format: "%.2f", dataModel.amount / holdings.totalValue * 100)
                            self.selectedPie = "\(dataModel.name) achieves \(percentage)% of the total assets"
                        } else {
                            self.selectedPie = ""
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width/1.5, height:  UIScreen.main.bounds.height/5)
                    
                    Text("\(selectedPie)")
                }
                
                ScrollView {
                    VStack {
                        Section("Asset Management") {
                            BarView(cryptoHoldings: [CryptoHolding(name:"Bitcoin", amount: 3.5), CryptoHolding(name: "Dodge", amount: 7)])
                                .frame(height: UIScreen.main.bounds.height/3.5)
                        }
                        Section("Holding List") {
                            CoinRow(coin: DeveloperPreview.instance.coin)
                        }
                       
                    }
                }
                
            } else {
                VStack(spacing: 30) {
                    VStack {
                        Text("$10,000")
                            .font(.system(size: 50))
                            .foregroundColor(Color.theme.accent)
                        Text("Total Balance")
                            .font(.caption)
                            .foregroundColor(Color.theme.accent)
                    }
                    
                    HStack {
                        Spacer()
                        Button(action: {
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
                        
                        Button(action: {
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
                    
                    VStack {
                        ZStack {
                            PieChart(dataModel: userAssets) { dataModel in
                                if let dataModel = dataModel {
                                    let percentage = String(format: "%.2f", dataModel.amount / holdings.totalValue * 0.01)
                                    self.selectedPie = "\(dataModel.name) achieves \(percentage)% of the total assets"
                                }else {
                                    self.selectedPie = ""
                                }
                                
                            }
                            
                            Circle()
                                .foregroundColor(.white)
                                .frame(width: UIScreen.main.bounds.width/1.5)
                            
                            Text("\(selectedPie)")
                                .frame(width: UIScreen.main.bounds.width/2)
                                .multilineTextAlignment(.center)
                            
                        }
                        .padding()
                        
                    }
                    
                    
                }
                
            }
            Spacer()
            
        }
    }
}


struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView(holdings: ChartDataModel.init(dataModel: [ChartCellModel(color: .orange, name:"Bitcoin", amount: 3.5), ChartCellModel(color: .red, name: "Dodge", amount: 7)]), userAssets: ChartDataModel.init(dataModel: [ChartCellModel(color: .purple, name: "Cash", amount: 10000), ChartCellModel(color: .pink, name: "Coins Value", amount: 50000)]))
    }
}
