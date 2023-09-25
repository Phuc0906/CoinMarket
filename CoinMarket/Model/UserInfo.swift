//
//  UserInfo.swift
//  CoinMarket
//
//  Created by Anh Nguyễn on 22/09/2023.
//

/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Nguyen Hung Anh
  ID: s3877798
  Created  date: 22/09/2023
  Last modified: 22/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import Foundation
struct UserInfo: Identifiable, Codable {
    var id: String
    var name: String
    var balance: String
}
