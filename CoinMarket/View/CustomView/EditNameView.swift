//
//  EditProfileView.swift
//  CoinMarket
//
//  Created by hhhh on 22/09/2023.
//

import SwiftUI
import Firebase

struct EditNameView: View {
    
    @ObservedObject private var userManager = UserManager()
    @ObservedObject private var authVM = AuthViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var name_placeholder: String?{
        return userManager.userInfo?.name
    }
    
    var email_placeholder: String?{
        return userManager.userInfo?.name
    }
    
    @State private var newName = ""
    @State private var newEmail = ""
    
    var body: some View {
        
        ZStack{
            Color.theme.background.ignoresSafeArea()
            
            GeometryReader{ geometry in
                
                VStack(spacing: 30){
                    Text("Edit profile")
                        .font(.custom("WixMadeforDisplay-ExtraBold", size: UIDevice.isIPhone ? 25 : 40))
                        .padding(.vertical)
                        .foregroundColor(Color.theme.accent)
                    
                    VStack(alignment: .leading, spacing: 5){
                        Text("Name")
                            .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 20 : 30))
                            .foregroundColor(Color.theme.accent)
                        TextField(name_placeholder ?? "None", text: $newName)
                            .modifier(TextFieldModifier())
                        
                    }
                    
                    Button(action: {
                        // Save user info
                        if !newName.isEmpty{
                            update()
                            presentationMode.wrappedValue.dismiss()
                        }
                        else{
                            print("Name is empty")
                        }
                        
                    }) {
                        Text("Update")
                            .modifier(LongButton())
                            .foregroundColor(.black)
                    }
                    
                    Button(action: {
                        // Handle restarting the game here
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Cancel")
                            .modifier(SignOutButton())
                            .foregroundColor(.black)
                    }
                    
                    
                }
                .frame(width: UIDevice.isIPhone ? geometry.size.width * 0.8 : geometry.size.width * 0.6)
                .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.5)
                
            }
        }
    }
    
    func update() {
        if var user = userManager.userInfo {
            user.name = newName
            if let userId = authVM.user?.uid {
                let newUser = UserInfo(id: userId, name: newName, balance: user.balance)
                userManager.saveUserInfo(user: newUser)
            }
        }
    }
    
}

struct EditNameView_Previews: PreviewProvider {
    static var previews: some View {
        EditNameView()
    }
}
