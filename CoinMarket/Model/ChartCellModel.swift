//
//  ChartCellModel.swift
//  CoinMarket
//
//  Created by Zoey on 19/09/2023.
//

import Foundation
import SwiftUI
struct ChartCellModel: Identifiable {
    let id = UUID()
    let color: Color
    let name: String
    let amount: Double
}
