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
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            Color(UIColor(red: 1.00, green: 0.87, blue: 0.16, alpha: 1.00))
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("LOGIN")
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
                
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()

                Button(action: login) {
                    Text("Login")
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
