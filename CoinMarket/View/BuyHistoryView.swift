//
//  BuyHistoryView.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 23/09/2023.
//

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
