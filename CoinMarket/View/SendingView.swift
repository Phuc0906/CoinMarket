//
//  SendingView.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 20/09/2023.
//

import SwiftUI

struct SendingView: View {
    @State private var amount: String = ""
    
    var body: some View {
        NavigationView {
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
                                Spacer()
                            }
                            
                        }
                        .frame(height: 20)
                        .padding(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 20))
                            .background(Color(UIColor(red: 0.93, green: 0.91, blue: 0.91, alpha: 1.00)))
                            .cornerRadius(5)
                    
                        
                            
                    }
                }.padding(EdgeInsets(top: 30, leading: 15, bottom: 20, trailing: 15))
                
                Spacer()
                Button {

                    
                    
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
    }
}

struct SendingView_Previews: PreviewProvider {
    static var previews: some View {
        SendingView()
    }
}
