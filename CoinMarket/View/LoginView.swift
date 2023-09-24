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
    
    @State private var language = true //true = English, false  = Vietnamese
    @State private var theme = true // true = light, false = dark
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            
            
            
            // MARK: - BODY
            GeometryReader{ geometry in
                HStack{
                    Spacer()
                    //language button
                    Button(action: {
                        // Add your action here
                        print("Change language")
                        language.toggle()
                    }) {
                        Image(language ? "uk" : "vietnam")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIDevice.isIPhone ? 40 : 50)
                    }
                    // theme button
                    Button(action: {    
                        // Add your action here
                        print("Change mode")
                        language.toggle()
                    }) {
                        Image(systemName: theme ? "moon.fill" : "sun.max.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIDevice.isIPhone ? 40 : 50)
                    }
                }
                .padding(.horizontal, 10)
                
                VStack (alignment: .leading, spacing: 20){
                    
                    // MARK: - LOGO AND APP NAME
                    HStack{
                        Image("logo-transparent")
                            .resizable()
                            .scaledToFit()
                            .frame(height: UIDevice.isIPhone ? 100 : 150)
                        Text("CoinMarket")
                            .font(.custom("WixMadeforDisplay-ExtraBold", size: UIDevice.isIPhone ? 25 : 40))
                    }
                    
                    // MARK: - TAGLINE
                    Text(language ? "Nice to see you again" : "Rất vui được gặp lại bạn")
                        .font(.custom("WixMadeforDisplay-ExtraBold", size: UIDevice.isIPhone ? 25 : 40))
                        .padding(.vertical)
                    
                    // MARK: - FORM
                    VStack(alignment: .leading, spacing: 5){
                        Text("Email")
                            .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 20 : 30))
                        TextField("abc @gmail.com", text: $email)
                            .modifier(TextFieldModifier())
                            .autocapitalization(.none)
                    }
                    
                    VStack(alignment: .leading, spacing: 5){
                        Text(language ? "Password" : "Mật khẩu")
                            .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 20 : 30))
                        SecureField(language ? "Password" : "Mật khẩu", text: $password)
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
                            Text(language ? "Log in" : "Đăng nhập")
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
                            Text(language ? "or Register Now!" : "hoặc Đăng kí ngay!")
                                .font(.custom("WixMadeforDisplay-Medium", size: UIDevice.isIPhone ? 20 : 30))
                        }
                        .padding(.bottom, 30)
                        
                        // MARK: - BUTTON START
                        Button(action: {
                            nextView = true
                        }) {
                            HStack {
                                Text(language ? "Get start" : "Bắt đầu")
                                    .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 25 : 35))
                                Image(systemName: "arrow.right")
                                    .foregroundColor(.black)
                            }.padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                                .background(.yellow)
                                .cornerRadius(30)
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
                presentationMode.wrappedValue.dismiss()
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
