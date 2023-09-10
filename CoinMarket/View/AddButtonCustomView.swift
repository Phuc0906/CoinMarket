//
//  AddButtonCustomView.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 10/09/2023.
//

import SwiftUI

struct AddButtonCustomView: View {
    @Binding var lastSelectedTab: Int
    @Binding var selectedTab: Int

    var body: some View {
        HStack {
            
        }.onAppear {
            selectedTab = lastSelectedTab
        }
    }
}

