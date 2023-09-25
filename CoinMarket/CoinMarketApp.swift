//
//  CoinMarketApp.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 08/09/2023.
//

/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Hoang Phuc
  ID: s3879362
  Created  date: 8/09/2023
  Last modified: 8/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI
import Firebase

@main
struct CoinMarketApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var vm = UserManager()
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environmentObject(vm)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
