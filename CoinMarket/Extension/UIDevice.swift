//
//  UIDevice.swift
//  CoinMarket
//
//  Created by hhhh on 17/09/2023.
//

/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Le Tan Phong
  ID: s3877819
  Created  date: 17/09/2023
  Last modified: 17/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import UIKit

extension UIDevice{
    static var isIPad: Bool{
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isIPhone: Bool{
        UIDevice.current.userInterfaceIdiom == .phone
    }
}
