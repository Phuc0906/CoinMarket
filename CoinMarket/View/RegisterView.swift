//
//  RegisterView.swift
//  CoinMarket
//
//  Created by Anh Nguyễn on 14/09/2023.
//

import SwiftUI
import Firebase

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var errorMessage = ""
    @Environment(\.presentationMode) var presentationMode
    
    @State var nextView: Bool = false
    @State var LoginView: Bool = false
    
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
                    
                    Text("Let's start your journey")
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
                    
                    
                    
                    VStack(alignment: .leading, spacing: 5){
                        Text("Password")
                            .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 20 : 30))
                        SecureField("Confirm Password", text: $confirmPassword)
                            .modifier(TextFieldModifier())
                    }
                    
                    
                    if !errorMessage.isEmpty{
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 16 : 25))
                    }
                    
                    Button(action: register) {
                        Text("Register")
                            .modifier(LongButton())
                    }
                    
                    VStack{
                        Button(action: {
                            LoginView = true
                        }) {
                            Text("Already have an account?")
                                .font(.custom("WixMadeforDisplay-Medium", size: UIDevice.isIPhone ? 20 : 30))
                        }
                        
                        // MARK: - BUTTON START
                        Button(action: {
                            nextView = true
                        }) {
                            ZStack {
                                Circle()
                                    .fill(RadialGradient(
                                        gradient: Gradient(colors: [Color.yellow, Color.orange]),
                                        center: .center,
                                        startRadius: 0,
                                        endRadius: 300
                                    ))
                                // Adjust the circle size
                                    .frame(width: UIDevice.isIPhone ? geometry.size.width * 0.3 : geometry.size.width * 0.2, height: UIDevice.isIPhone ? geometry.size.width * 0.3 : geometry.size.width * 0.2)
                                    .shadow(radius: 5)
                                
                                Text("Get start")
                                    .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 25 : 35))
                                    .foregroundColor(Color.theme.background)
                            }
                            
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                .frame(width: UIDevice.isIPhone ? geometry.size.width * 0.8 : geometry.size.width * 0.6)
                .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.5)
            }
            
        }
        .fullScreenCover(isPresented: $nextView) {
            MainView()
        }
        
        .fullScreenCover(isPresented: $LoginView) {
            CoinMarket.LoginView()
        }
        
    }
    
    func register() {
        if password == confirmPassword {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    errorMessage = error.localizedDescription
                } else {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        } else {
            errorMessage = "Passwords do not match."
        }
    }
    
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
            .previewDisplayName("iPhone 14 Pro Max")
        
        RegisterView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone 14")
        
        RegisterView()
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch)"))
            .previewDisplayName("iPad Pro")
    }
}

