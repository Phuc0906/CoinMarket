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
        VStack {
            Text("Login")
                .font(.largeTitle)
                .padding()

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Text(errorMessage)
                .foregroundColor(.red)
                .padding()

            Button(action: login) {
                Text("Login")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(5)
            }

            Spacer()
        }
        .padding()
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
