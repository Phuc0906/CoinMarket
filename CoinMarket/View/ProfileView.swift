//
//  ProfileView.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 10/09/2023.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var vm = AuthViewModel()
    
    var body: some View {
        Button {
            vm.signOut()
        } label: {
            Text("Sign out")
        }

    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
