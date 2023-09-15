//
//  CoinMarketApp.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 08/09/2023.
//

import SwiftUI
import Firebase

@main
struct CoinMarketApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var vm = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView(content: {
                HomeView()
                    .navigationBarHidden(true)
            })
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
