//
//  Double.swift
//  CoinMarket
//
//  Created by Zoey on 14/09/2023.
//

import Foundation

extension Double {
    /// convert a double into Currency with 2 decimal places
    /// ```
    /// Covert 1234.564 to $1,234.56
    /// ```
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        //        formatter.locale = .current
        //        formatter.currencyCode = "usd"
        //        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    
    /// convert a double into Currency as a String with 2-6 decimal places
    /// ```
    /// Covert 1234.564 to "$1,234.56"
    /// ```
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    
    /// convert a double into Currency with 2-6 decimal places
    /// ```
    /// Covert 1234.56 to $1,234.56
    /// Covert 12.3456 to $12.3456
    /// Covert 0.123456 to $0.123456
    /// ```
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        //        formatter.locale = .current
        //        formatter.currencyCode = "usd"
        //        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    
    /// convert a double into Currency as a String with 2-6 decimal places
    /// ```
    /// Covert 1234.56 to "$1,234.56"
    /// Covert 12.3456 to "$12.3456"
    /// Covert 0.123456 to "$0.123456"
    /// ```
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
    /// convert a double into a String representation
    /// ```
    /// Covert 1.2345 to "1.23"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// convert a double into a String representation with percentage symbol
    /// ```
    /// Covert 1.2345 to "1.23%"
    /// ```
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
}
