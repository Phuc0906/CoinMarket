//
//  BuyHistoryView.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 23/09/2023.
//

/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Hoang Phuc
  ID: s3879362
  Created  date: 23/09/2023
  Last modified: 23/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct BuyHistoryView: View {
    @EnvironmentObject private var vm: BuyHistoryViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(vm.buyHistory, id: \.id) {transaction in
                        TransactionRow(coin: vm.getCoin(transaction: transaction), transaction: transaction)
                    }
                }
            }.navigationTitle("Transaction History")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Done")
                                .foregroundColor(.blue)
                        }

                    }
                }
        }
    }
}

struct BuyHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        BuyHistoryView()
    }
}
