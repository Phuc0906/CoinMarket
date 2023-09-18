//
//  LoginView.swift
//  CoinMarket
//
//  Created by Anh Nguyễn on 14/09/2023.
//

import SwiftUI
import Firebase


struct LoginView: View {
    
    // MARK: - PROPERTIES
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    
    @State var nextView: Bool = false
    @State var RegisterView: Bool = false
    

    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            
            // MARK: - BODY
            GeometryReader{ geometry in
                
                VStack (alignment: .leading, spacing: 20){
                    
                    // MARK: - LOGO AND APP NAME
                    HStack{
                        Image("logo-transparent")
                            .resizable()
                            .scaledToFit()
                            .frame(height: UIDevice.isIPhone ? 100 : 150)
                        Text("App name")
                            .font(.custom("WixMadeforDisplay-ExtraBold", size: UIDevice.isIPhone ? 25 : 40))
                    }
                    
                    // MARK: - TAGLINE
                    Text("Nice to see you again")
                        .font(.custom("WixMadeforDisplay-ExtraBold", size: UIDevice.isIPhone ? 25 : 40))
                        .padding(.vertical)
                    
                    // MARK: - FORM
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
                    
                    // MARK: - LOGIN AND FACEID
                    HStack (spacing: 10){
                        Button(action: login) {
                            Text("Log in")
                                .modifier(LongButton())
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
                    
                    // MARK: - FOOTER
                    VStack{
                        Button(action: {
                            RegisterView = true
                        }) {
                            Text("or Register Now")
                                .font(.custom("WixMadeforDisplay-Medium", size: UIDevice.isIPhone ? 20 : 30))
                        }
                        .padding(.bottom, 30)
                        
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
                                    .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 22 : 30))
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
        .fullScreenCover(isPresented: $RegisterView) {
            CoinMarket.RegisterView()
        }
    }
    
    // MARK: - LOGIN FUNCTION
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
    @State private static var nextView = false
    @State private static var registerView = false
    
    static var previews: some View {
        LoginView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
            .previewDisplayName("iPhone 14 Pro Max")
        
        LoginView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone 14")
        
        LoginView()
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch)"))
            .previewDisplayName("iPad Pro")
    }
}
