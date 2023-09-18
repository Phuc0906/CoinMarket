//
//  UIDevice.swift
//  CoinMarket
//
//  Created by hhhh on 17/09/2023.
//

import UIKit

extension UIDevice{
    static var isIPad: Bool{
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isIPhone: Bool{
        UIDevice.current.userInterfaceIdiom == .phone
    }
}
