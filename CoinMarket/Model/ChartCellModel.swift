//
//  ChartCellModel.swift
//  CoinMarket
//
//  Created by Zoey on 19/09/2023.
//

/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Thai Thuan
  ID: s3877024
  Created  date: 19/09/2023
  Last modified: 19/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import Foundation
import SwiftUI
struct ChartCellModel: Identifiable {
    let id = UUID()
    let color: Color
    let name: String
    let amount: Double
}
