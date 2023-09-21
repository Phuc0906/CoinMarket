//
//  ReceiverCodeInputView.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 20/09/2023.
//

import SwiftUI

struct ReceiverCodeInputView: View {
    @EnvironmentObject private var vm: ReceiverInputViewModel
    @State private var receiverID: String = ""
    @State private var userIsNotExist = false
    @State private var toSendingView = false
    @StateObject private var sendingVM = SendingViewModel()
    
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                VStack {
                    TextField("Enter receiver id", text: $receiverID)
                        .padding(EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 30))
                        .background(.gray)
                        .cornerRadius(30)
                    if userIsNotExist {
                        Text("User is not exist")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                        
                }
                
                NavigationLink(isActive: $toSendingView, destination: {
                    SendingView(receiver: receiverID)
                        .environmentObject(sendingVM)
                }) {
                    
                }
                
                Button {
                    if !receiverID.isEmpty {
                        vm.verifyUser(userId: receiverID) { result in
                            verifyReceiver(verify: result)
                        }
                        
                    }
                } label: {
                    Text("Enter")
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                        .background(.blue)
                        .cornerRadius(30)
                }

            }.padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
        }
    }
    func verifyReceiver(verify: Bool) {
        if verify {
            userIsNotExist = false
            toSendingView = true
            print("To sending view")
        }else {
            userIsNotExist = true
        }
    }
}

struct ReceiverCodeInputView_Previews: PreviewProvider {
    static var previews: some View {
        ReceiverCodeInputView()
    }
}
