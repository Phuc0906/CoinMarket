//
//  BarView.swift
//  CoinMarket
//
//  Created by Zoey on 18/09/2023.
//

/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Thai Thuan
  ID: s3877024
  Created  date: 18/09/2023
  Last modified: 18/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI
import Charts

struct CryptoHolding: Identifiable {
    let id = UUID().uuidString
    let name: String
    let amount: Double
}


struct BarView: View {
    @State private var selectedCryptoHolding: CryptoHolding? // Add a state variable to store the selected CryptoHolding
    let cryptoHoldings:[CryptoHolding]
    var body: some View {
        Chart {
            ForEach(cryptoHoldings) { d in
                BarMark(x: PlottableValue.value("Name", d.name), y:PlottableValue.value("Amount", d.amount))
                    .foregroundStyle(by: .value("Name", d.name))
                    .annotation {
                        Text("\(String(format: "%.1f", d.amount))")
                    }
            }
            
        }
        .padding()
        
    }
}


struct BarView_Previews: PreviewProvider {
    static var previews: some View {
        BarView(cryptoHoldings: [CryptoHolding(name:"Bitcoin", amount: 3.5), CryptoHolding(name: "Dodge", amount: 7)]).previewLayout(.sizeThatFits)
    }
}
