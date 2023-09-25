//
//  TransferView.swift
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
import CodeScanner

struct TransferView: View {
    @EnvironmentObject private var vm: TransferViewModel
    @StateObject private var receiverInputVM = ReceiverInputViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var isShowingScanner = false
    @State private var receiverId: String = ""
    @State private var toCodeInputField = false
    @ObservedObject private var uVm = UserManager()
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text("\(vm.getUserName())")
                        .fontWeight(.bold)
                        .font(.title)
                }.padding(EdgeInsets(top: 30, leading: 20, bottom: 0, trailing: 20))
                Spacer()
                if let id = uVm.userInfo?.id {
                    Text("Wallet ID: \(id)")
                        .font(.headline )
                        .foregroundColor(Color.theme.accent)
                } else {
                    Text("")
                }

                
                Image(uiImage: UIImage(data: generateQRCode(userId: vm.getUserId()))!)
                    .resizable()
                    .frame(width: 200, height: 200)
                Spacer()
                
                NavigationLink(isActive: $toCodeInputField) {
                    ReceiverCodeInputView(receiverID: receiverId , presentationMode: self.presentationMode)
                        .environmentObject(receiverInputVM)
                } label: {
                    
                }

                
                Button {
                    isShowingScanner = true
                } label: {
                    HStack {
                        Text("Scan QR code to send crypto")
                            .foregroundColor(.white)
                            .padding(EdgeInsets(top: 15, leading: 40, bottom: 15, trailing: 40))
                            .background(LinearGradient(
                                gradient: Gradient(colors: [Color.yellow, Color.orange]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                            .cornerRadius(30)
                    }
                }
                Button {
                    toCodeInputField = true
                } label: {
                    HStack {
                        Text("Enter code to send crypto")
                            .foregroundColor(.white)
                            .padding(EdgeInsets(top: 15, leading: 40, bottom: 15, trailing: 40))
                            .background( LinearGradient(
                                gradient: Gradient(colors: [Color.yellow, Color.orange]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                            .cornerRadius(30)
                        
                    }
                }
                Spacer()

            }
            .sheet(isPresented: $isShowingScanner, content: {
                CodeScannerView(codeTypes: [.qr], completion: handleCan)
            })
            .navigationTitle(Text("Your QR Code"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Done")
                            .foregroundColor(Color.theme.secondaryText)
                    }
                }
            }
        }
        
    }
    
    func handleCan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        switch result {
        case .success(let result):
            let data = result.string
            print("Result: \(data)")
            vm.verifyUser(userId: data) { result in
                if result {
                    self.receiverId = data
                    self.toCodeInputField = true
                }
            }
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func generateQRCode(userId: String) -> Data {
        let filter = CIFilter(name: "CIQRCodeGenerator")
        let data = userId.data(using: .ascii, allowLossyConversion: false)
        filter?.setValue(data, forKey: "inputMessage")
        let image = filter?.outputImage
        let uiimage = UIImage(ciImage: image!)
        return uiimage.pngData()!
    }
}

struct TransferView_Previews: PreviewProvider {
    static var previews: some View {
        TransferView().environmentObject(TransferViewModel())
    }
}
