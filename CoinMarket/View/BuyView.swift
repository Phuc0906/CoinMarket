//
//  BuyView.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 15/09/2023.
//

/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Hoang Phuc
  ID: s3879362
  Created  date: 15/09/2023
  Last modified: 15/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct BuyView: View {
    @State var coin: Coin
    @State private var amount: String = ""
    @State private var holder: String = ""
    @State private var alertOutOfBalance = false
    @StateObject private var auth = AuthViewModel()
//    @StateObject private var buyVM = BuyViewModel()
    @EnvironmentObject private var buyVM: BuyViewModel
    @Environment(\.presentationMode) var presentationMode

    @State var isBuy: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                buyInfo
                VStack {
                    VStack {
                        HStack {
                            Text("I want to \(isBuy ? "buy" : "sell")")
                                .font(.body)
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        
                        ZStack {
                            HStack {
                                Text("\(amount)")
                                    .foregroundColor(.black)
                            }
                               
                            
                            HStack {
                                Spacer()
                                Text(isBuy ? "USD" : "\(coin.symbol.uppercased())")
                                    .foregroundColor(.black)
                            }
                        }
                        .frame(height: 20)
                        .padding(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 20))
                            .background(Color(UIColor(red: 0.93, green: 0.91, blue: 0.91, alpha: 1.00)))
                            .cornerRadius(5)
                        
                        HStack {
                            Text(isBuy ? "5 - 20,000 $" : "\(buyVM.isUserHasCoin(coinID: coin.id) ? "You are holding \(buyVM.getUserHolding(coinID: coin.id)) \(coin.symbol.uppercased())" : "You do not have \(coin.name.uppercased())")")
                                .font(.footnote)
                                .foregroundColor(.gray)
                            Spacer()
                        }
                    }
                }.padding(EdgeInsets(top: 30, leading: 15, bottom: 20, trailing: 15))
                
                Spacer()
                CustomKeyPad(input: $amount)
                Button {
                    if let user = buyVM.userManager.userInfo {
                        let userBalance = user.balance
                        if Double(userBalance)! < Double(amount)! {
                            alertOutOfBalance = true
                        }else {
                            buyVM.userManager.getTransactions()
                            if isBuy && !amount.isEmpty {
                                if let user = auth.user {
                                    let transaction = Transaction(coinId: coin.id, userId: user.uid, amount: Double(amount)!, currentPrice: coin.current_price, transactionDate: Date())

                                    buyVM.buy(transaction: transaction) {
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                }
                            }else if !amount.isEmpty && buyVM.isUserHasCoin(coinID: coin.id) {
                                if let user = auth.user {
                                    if Double(amount)! <= buyVM.getUserHolding(coinID: coin.id) {
                                        let transaction = Transaction(coinId: coin.id, userId: user.uid, currentPrice: coin.current_price, numberOfCoin: Double(amount)!, transactionDate: Date())
                                        
                                        buyVM.sell(transaction: transaction) {
                                            self.presentationMode.wrappedValue.dismiss()
                                        }
                                    }else {
                                        // MARK: alert over amount
                                        print("Over holding")
                                    }
                                    
                                }
                            }else {
                                //MARK: alert to enter amount
                            }
                        }
                    }
                    
                    
                } label: {
                    VStack {
                        Text("\(isBuy ? "Buy" : "Sell")")
                    }
                    .frame(maxWidth: .infinity)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .background(.yellow)
                    .cornerRadius(20)
                }

                
            }.padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // action
                        isBuy.toggle()
                    } label: {
                        VStack {
                            Text("\(isBuy ? "Sell" : "Buy")")
                                .font(.body)
                                
                        }.padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                            .background(Color(UIColor(red: 0.93, green: 0.91, blue: 0.91, alpha: 1.00)))
                            .cornerRadius(30)
                    }

                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Done")
                    }

                }
            }
        }
    }
}



extension BuyView {
    private var buyInfo: some View {
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
            Text("Buy \(coin.symbol)")
                .textCase(.uppercase)
                .fontWeight(.bold)
            Spacer()
        }.alert("Not enough money", isPresented: $alertOutOfBalance) {
        }
    }
}
