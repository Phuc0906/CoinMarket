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
    
    var body: some View {
        ZStack{
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
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .white.opacity(0.05), radius: 70)
                    .padding()
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .white.opacity(0.05), radius: 70)
                    .padding()
                
                SecureField("Confirm Password", text: $confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
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
                
                
                Spacer()
            }
            .padding()
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
    }
}

