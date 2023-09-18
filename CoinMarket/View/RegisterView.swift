//
//  RegisterView.swift
//  CoinMarket
//
//  Created by Anh Nguyễn on 14/09/2023.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore



struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var name = ""
    @State private var balance = ""
    @State private var errorMessage = ""
    @Environment(\.presentationMode) var presentationMode
    
    @State var nextView: Bool = false
    @State var LoginView: Bool = false
    
    @State private var language = false
    
    var body: some View {
        
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            GeometryReader{ geometry in
                HStack{
                    Spacer()
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
            Color(UIColor(red: 1.00, green: 0.87, blue: 0.16, alpha: 1.00))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("REGISTER")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .white.opacity(0.05), radius: 70)
                    .padding()
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(Color.white)
                    .autocapitalization(.none)
                    .cornerRadius(10)
                    .shadow(color: .white.opacity(0.05), radius: 70)
                    .padding()
                
                SecureField("Confirm Password", text: $confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .white.opacity(0.05), radius: 70)
                    .padding()
                
                Text("USER INFO")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .white.opacity(0.05), radius: 70)
                    .padding()
                TextField("Balance", text: $balance)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .white.opacity(0.05), radius: 70)
                    .padding()
                
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
                
                Button(action: register) {
                    Text("Register")
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                        .font(.title2)
                        .foregroundColor(.blue)
                        .background(.white)
                        .cornerRadius(30)
                }
                .padding(.horizontal, 10)
                
                VStack (alignment: .leading, spacing: 20){
                    HStack{
                        Image("logo-transparent")
                            .resizable()
                            .scaledToFit()
                            .frame(height: UIDevice.isIPhone ? 100 : 150)
                        Text("CoinMarket")
                            .font(.custom("WixMadeforDisplay-ExtraBold", size: UIDevice.isIPhone ? 25 : 40))
                    }
                    
                    Text(language ? "Let's start your journey" : "Bắt đầu ngay bây giờ")
                        .font(.custom("WixMadeforDisplay-ExtraBold", size: UIDevice.isIPhone ? 25 : 40))
                        .padding(.vertical)
                    
                    VStack(alignment: .leading, spacing: 5){
                        Text("Email")
                            .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 20 : 30))
                        TextField("Email", text: $email)
                            .modifier(TextFieldModifier())
                    }
                    
                    VStack(alignment: .leading, spacing: 5){
                        Text(language ? "Password" : "Mật khẩu")
                            .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 20 : 30))
                        SecureField(language ? "Password" : "Mật khẩu", text: $password)
                            .modifier(TextFieldModifier())
                    }
                    
                    
                    
                    VStack(alignment: .leading, spacing: 5){
                        Text(language ? "Confirm Password" : "Xác nhận mật khẩu")
                            .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 20 : 30))
                        SecureField(language ? "Confirm Password" : "Xác nhận mật khẩu", text: $confirmPassword)
                            .modifier(TextFieldModifier())
                    }
                    
                    
                    if !errorMessage.isEmpty{
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 16 : 25))
                    }
                    
                    Button(action: register) {
                        Text(language ? "Register" : "Đăng kí")
                            .modifier(LongButton())
                    }
                    
                    VStack{
                        Button(action: {
                            LoginView = true
                        }) {
                            Text(language ? "Already have an account?" : "Bạn có tài khoản rồi?")
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
                                
                                Text(language ? "Get start" : "Bắt đầu")
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
                    if let user = authResult?.user {
                        let userID = user.uid
                        
                        print("User ID: \(userID)")
                        let newUser = UserInfo(id: userID, name: name, balance: balance)
                        saveUserData(user: newUser)
                        
                    }
                    presentationMode.wrappedValue.dismiss()
                }
            }
        } else {
            errorMessage = language ? "Passwords do not match." : "Mật khẩu không đúng."
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

