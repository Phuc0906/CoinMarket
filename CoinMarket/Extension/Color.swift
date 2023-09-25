//
//  Color.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 13/09/2023.
//

/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Hoang Phuc
  ID: s3879362
  Created  date: 13/09/2023
  Last modified: 13/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
}

//struct ColorTheme2 {
//    let accent = Color(#colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1))
//    let background = Color(#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1))
//    let green = Color(#colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1))
//    let red = Color(#colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1))
//    let secondaryText = Color(#colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1))
//}

//struct LaunchTheme {
//
//    let accent = Color("LaunchAccentColor")
//    let background = Color("LaunchBackgroundColor")
//
//}
