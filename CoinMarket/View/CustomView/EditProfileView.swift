//
//  EditProfileView.swift
//  CoinMarket
//
//  Created by hhhh on 22/09/2023.
//

import SwiftUI
import Firebase

struct EditProfileView: View {
    var dismiss: () -> Void // A closure to handle restarting the game
    
    @ObservedObject private var userManager = UserManager()
    
    var user: UserInfo? {
        return userManager.userInfo
    }
    
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
            Color.white.ignoresSafeArea()
            
            GeometryReader{ geometry in
                
                VStack(spacing: 30){
                    Text("Edit profile")
                        .font(.custom("WixMadeforDisplay-ExtraBold", size: UIDevice.isIPhone ? 25 : 40))
                        .padding(.vertical)
                    
//                    VStack(alignment: .leading, spacing: 5){
//                        Text("Email")
//                            .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 20 : 30))
//                        TextField(email_placeholder ?? "None", text: $newEmail)
//                            .modifier(TextFieldModifier())
//                    }
                    
                    VStack(alignment: .leading, spacing: 5){
                        Text("Name")
                            .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 20 : 30))
                        TextField(name_placeholder ?? "None", text: $newName)
                            .modifier(TextFieldModifier())
                    }
                    
                    Button(action: {
                        // Save user info
                        if !newName.isEmpty{
                            register()
                            dismiss()
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
                        dismiss()
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
    
    func register() {
        if let user = user {
            let newUser = UserInfo(id: user.id, name: newName, balance: user.balance)
            saveUserData(user: newUser)
        }
    }
    
    func saveUserData(user: UserInfo) {
        let db = Firestore.firestore()
        
        do {
            let encodedData = try JSONEncoder().encode(user)
            let jsonString = String(data: encodedData,
                                    encoding: .utf8)
            db.collection("users").document("\(user.id)").setData(["profile": jsonString!])
        }catch{
            print("error")
        }
    }
    
    
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(dismiss: {})
    }
}
