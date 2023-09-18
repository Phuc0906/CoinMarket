//
//  LoginView.swift
//  CoinMarket
//
//  Created by Anh Nguyễn on 14/09/2023.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            GeometryReader{ geometry in
                
                VStack (alignment: .leading, spacing: 20){
                    HStack{
                        Image("logo-transparent")
                            .resizable()
                            .scaledToFit()
                            .frame(height: UIDevice.isIPhone ? 100 : 150)
                        Text("App name")
                            .font(.custom("WixMadeforDisplay-ExtraBold", size: UIDevice.isIPhone ? 25 : 40))
                    }
                    .padding(.bottom, 50)
                    
                    Text("Nice to see you again")
                        .font(.custom("WixMadeforDisplay-ExtraBold", size: UIDevice.isIPhone ? 25 : 40))
                        .padding(.vertical)
                    
                    VStack(alignment: .leading, spacing: 5){
                        Text("Email")
                            .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 20 : 30))
                        TextField("Email", text: $email)
                            .modifier(TextFieldModifier())
                    }
                    
                    VStack(alignment: .leading, spacing: 5){
                        Text("Password")
                            .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 20 : 30))
                        SecureField("Password", text: $password)
                            .modifier(TextFieldModifier())
                    }
                    
                    if !errorMessage.isEmpty{
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 16 : 25))
                    }
                    
                    HStack (spacing: 10){
                        Button(action: login) {
                            Text("Log in")
                                .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 25 : 40))
                                .frame(maxWidth: .infinity, maxHeight: UIDevice.isIPhone ? 50 : 70)
                                .background(.yellow)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        
                        
                        Button(action: login){
                            Image("face-scanner")
                                .resizable()
                                .scaledToFit()
                                .frame(height: UIDevice.isIPhone ? 40 : 60)
                                .padding(5)
                        }
                        .background(Color("TextField"))
                        .cornerRadius(10)
                        
                    }
                    
                    
                    
                }
                .frame(width: UIDevice.isIPhone ? geometry.size.width * 0.8 : geometry.size.width * 0.5)
                .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.5)
            }
            
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                print("login")
            }
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
            .previewDisplayName("iPhone 14 Pro Max")
        
        LoginView()
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch)"))
            .previewDisplayName("iPad Pro")
    }
}
