//
//  Coin.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 11/09/2023.
//

import Foundation

struct Coin: Codable {
    let id, symbol, name: String
    let image: String
    let current_price: Double
    let market_cap, market_cap_rank: Int
    let fully_diluted_valuation: Int?
    let total_volume, high_24h, low_24h, price_change_24h: Double
    let price_change_percentage_24h, market_cap_change_24h, market_cap_change_percentage_24h, circulating_supply: Double
    let total_supply, max_supply: Double?
    let ath, ath_change_percentage: Double
    let ath_date: String
    let atl, atl_change_percentage: Double
    let atl_date: String
    let roi: Roi?
    let last_updated: String
    let sparkline_in_7d: SparklineIn7D

}

// MARK: - Roi
struct Roi: Codable {
    let times: Double
    let currency: Currency
    let percentage: Double
}

enum Currency: String, Codable {
    case btc = "btc"
    case eth = "eth"
    case usd = "usd"
}

// MARK: - SparklineIn7D
struct SparklineIn7D: Codable {
    let price: [Double]
}
