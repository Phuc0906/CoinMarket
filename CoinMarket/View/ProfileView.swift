//
//  ProfileView.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 10/09/2023.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var vm = AuthViewModel()
    @ObservedObject private var userManager = UserManager()
    @Environment(\.colorScheme) var colorScheme
    @State private var language = true
    
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            
            VStack(spacing: 0){
                HStack{
                    Text(language ? "Profile" : "Hồ sơ")
                        .font(.custom("WixMadeForDisplay-ExtraBold", size: UIDevice.isIPhone ? 40 : 50))
                        .foregroundColor(Color.theme.accent)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                
                
                // MARK: ID CARD
                VStack(alignment: .leading) {
                    //MARK: LOGO
                    HStack(spacing: 0){
                        Spacer()
                        Image("logo-transparent")
                            .resizable()
                            .scaledToFit()
                            .frame(height: UIDevice.isIPhone ? 60 : 150)
                        Text("CoinMarket")
                            .font(.custom("WixMadeforDisplay-ExtraBold", size: UIDevice.isIPhone ? 25 : 40))
                            .foregroundColor(.white)
                    }
                    
                    //MARK: INFO
                    if let user = userManager.userInfo{
                        VStack(alignment: .leading, spacing: 10){
                            Text(user.name)
                                .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 25 : 40))
                                .foregroundColor(.white)
                            
                            HStack(spacing: 50){
                                VStack(alignment: .leading){
                                    Text("UserId")
                                        .font(.custom("WixMadeforDisplay-Medium", size: UIDevice.isIPhone ? 20 : 40))
                                    Text("12345")
                                        .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 20 : 40))
                                }
                                
                                
                                VStack(alignment: .leading){
                                    Text("Email")
                                        .font(.custom("WixMadeforDisplay-Medium", size: UIDevice.isIPhone ? 20 : 40))
                                    Text("12345")
                                        .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 20 : 40))
                                }
                            }
                            .foregroundColor(.white)
                        }
                    }
                    else {
                        Text("User name")
                            .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 25 : 40))
                            .foregroundColor(.white)
                    }
                }
                .frame(maxWidth: 320)
                .padding(EdgeInsets(top: 30, leading: 25, bottom: 30, trailing: 30))
                .background(.cyan.opacity(0.8))
                .cornerRadius(20)
                
                // MARK: SETTING
                
                ZStack (alignment: .topLeading){
                    Color.black
                    RoundedRectangle(cornerRadius: 20) // Rounded border
                        .stroke(Color.gray, lineWidth: 0.1) // Border color and width
                        .background(
                            RoundedRectangle(cornerRadius: 20) // Rounded border background
                                .fill(Color.white) // Border background color
                                .shadow(color: Color.gray, radius: 5, x: 0, y: 2) // Shadow for the border
                        )
                    
                    
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading){
                            // Row Profile
                            Button(action: {
                                print("Edit profile")
                            }) {
                                HStack(spacing: 20){
                                    Image("profile")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIDevice.isIPhone ? 35 : 50, height: UIDevice.isIPhone ? 35 : 50)
                                    Text("Edit profile information")
                                    Spacer()
                                }
                            }
                            
                            // Row notification
                            Button(action: {
                                print("Edit notification")
                            }) {
                                HStack(spacing: 20){
                                    Image("noti")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIDevice.isIPhone ? 35 : 50, height: UIDevice.isIPhone ? 35 : 50)
                                    Text("Notification")
                                    Spacer()
                                }
                            }
                            
                            // Row Theme
                            Button(action: {
                                print("Edit theme")
                            }) {
                                HStack(spacing: 20){
                                    Image("theme")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIDevice.isIPhone ? 35 : 50, height: UIDevice.isIPhone ? 35 : 50)
                                    Text("Theme")
                                    Spacer()
                                }
                            }
                            
                            
                            // Row language
                            Button(action: {
                                print("Edit language")
                            }) {
                                HStack(spacing: 20){
                                    Image("lang")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIDevice.isIPhone ? 35 : 50, height: UIDevice.isIPhone ? 35 : 50)
                                    Text("Language")
                                    
                                    Spacer()
                                    
                                    Image(language ? "uk" : "vietnamese")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIDevice.isIPhone ? 35 : 50)
                                }
                            }
                            
                            
                        }
                        
                        
                        
                    }
                    .frame(width: 320)
                    .padding(EdgeInsets(top: 30, leading: 25, bottom: 30, trailing: 25))
                    //                        .background(.blue)
                }
                .frame(maxWidth: 0)
                .frame(height: 0)
                
                Spacer()
                Button {
                    vm.signOut()
                } label: {
                    Text("Sign out")
                }
                
                
            }
            
            
            
        }
        
        
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
