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
    
    @State private var showEditProfile = false
    @Environment(\.colorScheme) var colorScheme
    @State private var language = true
    
    @State private var user: UserInfo?
    
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            
            VStack(spacing: UIDevice.isIPhone ? 20 : 50){
                HStack{
                    Text(language ? "Profile" : "Hồ sơ")
                        .font(.custom("WixMadeForDisplay-ExtraBold", size: UIDevice.isIPhone ? 40 : 50))
                        .foregroundColor(Color.theme.accent)
                        .fontWeight(.bold)
                    Spacer()
                    
                    
                }
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 10))
                
                
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
                    if let user = user{
                        VStack(alignment: .leading, spacing: 10){
                            Text(user.name)
                                .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 25 : 40))
                                .foregroundColor(.white)
                            
                            HStack(spacing: 50){
                                //                                VStack(alignment: .leading){
                                //                                    Text("UserId")
                                //                                        .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 16 : 30))
                                //                                    Text(user.id)
                                //                                        .font(.custom("WixMadeforDisplay-Medium", size: UIDevice.isIPhone ? 16   : 30))
                                //                                }
                                
                                
                                VStack(alignment: .leading){
                                    Text("Email")
                                        .font(.custom("WixMadeforDisplay-Medium", size: UIDevice.isIPhone ? 20 : 40))
                                    Text("Email???")
                                        .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 20 : 40))
                                }
                            }
                            .foregroundColor(.white)
                        }
                    }
                    else {
                        Text("No user found")
                            .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 25 : 40))
                            .foregroundColor(.white)
                    }
                }
                .frame(maxWidth: UIDevice.isIPhone ? 320 : 600)
                .padding(EdgeInsets(top: 30, leading: 25, bottom: 30, trailing: 30))
                .background(.cyan.opacity(0.8))
                .cornerRadius(20)
                
                // MARK: SETTING
                
                VStack(alignment: .leading) {
                    VStack(alignment: .leading){
                        // Row Profile
                        Button(action: {
                            if let user = user{
                                print(user.id)
                            }
                            
                            showEditProfile.toggle()
                        }) {
                            HStack(spacing: 20){
                                Image("profile")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIDevice.isIPhone ? 35 : 60, height: UIDevice.isIPhone ? 35 : 60)
                                Text("Edit profile information")
                                    .modifier(TextModifier())
                                
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
                                    .frame(width: UIDevice.isIPhone ? 35 : 60, height: UIDevice.isIPhone ? 35 : 60)
                                Text("Notification")
                                    .modifier(TextModifier())
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
                                    .frame(width: UIDevice.isIPhone ? 35 : 60, height: UIDevice.isIPhone ? 35 : 60)
                                Text("Theme")
                                    .modifier(TextModifier())
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
                                    .frame(width: UIDevice.isIPhone ? 35 : 60, height: UIDevice.isIPhone ? 35 : 60)
                                Text("Language")
                                    .modifier(TextModifier())
                                
                                Spacer()
                                
                                Image(language ? "uk" : "vietnamese")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIDevice.isIPhone ? 35 : 60)
                            }
                        }
                    }
                }
                .frame(maxWidth: UIDevice.isIPhone ? 320 : 600)
                .padding(EdgeInsets(top: 30, leading: 25, bottom: 30, trailing: 25))
                .foregroundColor(.black)
                .background(
                    RoundedRectangle(cornerRadius: 20) // Rounded border
                        .stroke(Color.gray, lineWidth: 0.1) // Border color and width
                        .background(
                            RoundedRectangle(cornerRadius: 20) // Rounded border background
                                .fill(Color.white) // Border background color
                                .shadow(color: Color.gray, radius: 5, x: 0, y: 2) // Shadow for the border
                        )
                )
                
                
                Spacer()
                Button {
                    vm.signOut()
                } label: {
                    Text("Sign out")
                        .modifier(SignOutButton())
                    
                }
                .frame(maxWidth: 320)
                Spacer()
            }
        }
        .sheet(isPresented: $showEditProfile){
            EditProfileView(dismiss: dismiss)
        }
        .onAppear {
            // Fetch or load user data when the view appears
            if let fetchedUser = userManager.userInfo {
                // Assign the fetched user data to the State property
                self.user = fetchedUser
            } else {
                // Handle the case where user data couldn't be loaded
                // For example, show an error message or take appropriate action
                print("User data couldn't be loaded.")
            }
        }
    }
    
    //MARK: FUNCTIONS
    private func dismiss(){
        showEditProfile.toggle()
    }
    
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone 14")
        
        ProfileView()
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch)"))
            .previewDisplayName("iPad Pro")
    }
}
