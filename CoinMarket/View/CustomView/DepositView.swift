//
//  DepositView.swift
//  CoinMarket
//
//  Created by hhhh on 24/09/2023.
//

import SwiftUI

struct DepositView: View {
    //MARK: PROPERTY
    @State var amount = "" //money
    
    @ObservedObject private var userManager = UserManager()
    @Environment(\.presentationMode) var presentationMode
    
    //MARK: BODY
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            
            GeometryReader{ geometry in
                //MARK: TITLE
                VStack(spacing: 30){
                    Text("Deposit")
                        .font(.custom("WixMadeforDisplay-ExtraBold", size: UIDevice.isIPhone ? 25 : 40))
                        .padding(.vertical)
                    
                    VStack(alignment: .leading, spacing: 5){
                        Text("Enter amount")
                            .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 20 : 30))
                        PrefixTextField(text: $amount, prefix: "$ ")
                    }
                    
                    //MARK: ADD AMOUNT AUTO
                    HStack{
                        Button(action: {
                            amount = "1000"
                        }) {
                            Text("$1000")
                                .modifier(MediumButton())
                                .foregroundColor(.black)
                        }
                        Button(action: {
                            amount = "10000"
                        }) {
                            Text("$10.000")
                                .modifier(MediumButton())
                                .foregroundColor(.black)
                        }
                        Button(action: {
                            amount = "20000"
                        }) {
                            Text("$20.000")
                                .modifier(MediumButton())
                                .foregroundColor(.black)
                        }
                    }
                    
                    //MARK: DEPOSIT BUTTON
                    Button(action: {
                        // Save user info
                        if !amount.isEmpty{
                            deposit()
                            presentationMode.wrappedValue.dismiss()
                        }
                        else{
                            print("Please enter amount")
                        }

                    }) {
                        Text("Deposit")
                            .modifier(LongButton())
                            .foregroundColor(.black)
                    }
                    
                    //MARK: CANCEL BUTTON
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
    
    //MARK: FUNCTIONS
    //function to update balance
    func deposit() {
        if let user = userManager.userInfo, let sum = addStringsAsNumbers(user.balance, amount) {
            let newUser = UserInfo(id: user.id, name: user.name, balance: sum)
            userManager.saveUserInfo(user: newUser)
        }
    }
    
    //add up balance which is a string
    func addStringsAsNumbers(_ num1: String, _ num2: String) -> String? {
        // Attempt to convert the input strings to integers
        if let intNum1 = Int(num1), let intNum2 = Int(num2) {
            // Add the two integers
            let result = intNum1 + intNum2
            // Convert the result back to a string
            return String(result)
        } else {
            // Handle cases where the input strings are not valid numbers
            return nil
        }
    }
}

//MARK: Custom text field to have prefix
struct PrefixTextField: View {
    @Binding var text: String
    var prefix: String
    
    var body: some View {
        HStack {
            Text(prefix)
            TextField("Enter text", text: $text)
                
        }
        .modifier(TextFieldModifier())
        .cornerRadius(10)
    }
}

struct DepositView_Previews: PreviewProvider {
    static var previews: some View {
        DepositView()
    }
}
