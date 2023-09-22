//
//  SendingView.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 20/09/2023.
//

import SwiftUI
import LocalAuthentication

struct SendingView: View {
    @EnvironmentObject private var vm: SendingViewModel
    @State private var amount: String = ""
    @State private var userWallet: [Transaction] = []
    @State private var currentUnit = ""
    @State private var currentSelectedTransaction: Transaction?
    @State var receiver: String = ""
    @Binding var presentationMode: PresentationMode
    
    var body: some View {
        VStack {
            VStack {
                VStack {
                    HStack {
                        Text("I want to transfer")
                            .font(.body)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    
                    ZStack {

                        HStack {
                            TextField("Enter transfer amount", text: $amount)
                                .keyboardType(.decimalPad)
                                
                            Spacer()
                        }
                        
                        HStack {
                            Spacer()
                            Text("\(currentUnit)")
                                .foregroundColor(.black)
                        }
                        
                    }
                    .frame(height: 20)
                    .padding(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 20))
                        .background(Color(UIColor(red: 0.93, green: 0.91, blue: 0.91, alpha: 1.00)))
                        .cornerRadius(5)
                
                    
                        
                }
            }.padding(EdgeInsets(top: 30, leading: 15, bottom: 20, trailing: 15))
            ScrollView {
                VStack {
                    ForEach(vm.userManager.getFilteredTransaction(), id: \.id) {transaction in
                        CoinHoldingRow(coin: vm.getCoin(coinId: transaction.coinId), transaction: transaction)
                            .onTapGesture {
                                currentUnit = vm.getCoin(coinId: transaction.coinId).symbol.uppercased()
                                currentSelectedTransaction = transaction
                            }
                    }
                }
            }
            
            
            Spacer()
            Button {
                if !amount.isEmpty && !receiver.isEmpty {
                    if let transaction = currentSelectedTransaction {
                        if Double(amount)! <= transaction.numberOfCoin {
                            // process transfer
                            vm.transfer(amount: Double(amount)!, selectedTransaction: transaction, receiverID: receiver) {
                                print("Execute dismiss")
                                self.presentationMode.dismiss()
                            }
//                            if getBiometricStatus() {
//                                authenticateUser {
//                                    print("Start transfer here")
//                                }
//                            }else {
//                                print(LAContext().biometryType)
//                                print("NO faceid")
//                            }
                        }else {
                            //MARK: alet over holding
                        }
                    }else {
                        //MARK: alert no coin selected
                    }
                }else {
                    //MARK: alert user to enter amount
                }
            } label: {
                VStack {
                    Text("Send")
                }
                .frame(maxWidth: .infinity)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                .background(.yellow)
                .cornerRadius(20)
            }

            
        }.padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
    }
    
    func getBiometricStatus() -> Bool {
        let scanner = LAContext()
        if scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none) {
            return true
        }
        return false
    }
    
    func authenticateUser(complete: @escaping () -> Void) {
        let scanner = LAContext()
        scanner.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To unlock \(String(describing: vm.userManager.userInfo?.name))") { status, error in
            if error != nil {
                print("Call error")
                print(error?.localizedDescription)
                return
            }
            print("Call")
            complete()
            
        }
    }
}

