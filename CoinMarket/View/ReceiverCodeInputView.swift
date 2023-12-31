//
//  ReceiverCodeInputView.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 20/09/2023.
//

/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Hoang Phuc
  ID: s3879362
  Created  date: 20/09/2023
  Last modified: 20/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct ReceiverCodeInputView: View {
    @EnvironmentObject private var vm: ReceiverInputViewModel
    @State var receiverID: String = ""
    @State private var userIsNotExist = false
    @State private var toSendingView = false
    @StateObject private var sendingVM = SendingViewModel()
    @Binding var presentationMode: PresentationMode
    
    
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
                    SendingView(receiver: receiverID, presentationMode: self.$presentationMode)
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
                .onAppear {
                    if !receiverID.isEmpty {
                        toSendingView = true
                    }
                }
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

