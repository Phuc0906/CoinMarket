//
//  UserInfo.swift
//  CoinMarket
//
//  Created by Anh Nguyễn on 22/09/2023.
//

import Foundation
struct UserInfo: Identifiable, Codable {
    var id: String
    var name: String
    var balance: String
}
