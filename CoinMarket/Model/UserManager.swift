//
//  UserManager.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 18/09/2023.
//

import Foundation
import Firebase
import FirebaseAuth

class UserManager: ObservableObject {
    @Published var transactions: [Transaction] = []
    @Published var buyHistory: [Transaction] = []
    @Published var wallet: [String:Transaction] = [:]
    @Published var userInfo: UserInfo?
    @Published var walletTransactions: [Transaction] = []
    private var auth = AuthViewModel()
    let db = Firestore.firestore()
    private var user: User?
    var receiverValidation = false
    
    init() {
        Auth.auth().addStateDidChangeListener { auth, user in
            self.user = user
            self.getTransactions()
            self.getUserInfo()
            self.getBuyHistory()
        }
    }
    
    private func getAllUsers() {
        db.collection("users").document()
    }
    
    private func saveUserInfo(user: UserInfo) {
        do {
            let encodedData = try JSONEncoder().encode(user)
            let jsonString = String(data: encodedData,
                                    encoding: .utf8)
            db.collection("users").document("\(user.id)").setData(["profile": jsonString!]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document user written!")
                }
            }
        }catch {
            
        }
    }
    
    func getBuyHistory() {
        if let user = auth.user {
            self.db.collection("buy_history").document("\(user.uid)").getDocument { (document, error) in
                
                if let document = document, document.exists {
                    
                    let dataTransactions = document.data()?.values.map(String.init(describing:))
                    
                    if let jsonData = dataTransactions![0].data(using: .utf8) {
                        do {
                            let transactions = try JSONDecoder().decode([Transaction].self, from: jsonData)
                            self.buyHistory = transactions
                        }catch {

                        }
                    }
                }
            }
        }
    }
    
    
    func getTransactions() {
        if let user = auth.user {
            var filteredTrans: [String:Transaction] = [:]
            self.db.collection("transactions").document("\(user.uid)").getDocument { (document, error) in
                
                if let document = document, document.exists {
                    
                    let dataTransactions = document.data()?.values.map(String.init(describing:))
                    
                    if let jsonData = dataTransactions![0].data(using: .utf8) {
                        
                        do {
                            let transactions = try JSONDecoder().decode([Transaction].self, from: jsonData)
                            for var transaction in transactions {
                                if filteredTrans.keys.contains(transaction.coinId) {
                                    transaction.numberOfCoin += filteredTrans[transaction.coinId]?.numberOfCoin ?? 0
                                    transaction.amount += filteredTrans[transaction.coinId]?.amount ?? 0
                                    filteredTrans[transaction.coinId] = transaction
                                }else {
                                    filteredTrans[transaction.coinId] = transaction
                                }
                            }
                            self.buyHistory = transactions
                            self.transactions = transactions
                            self.wallet = filteredTrans
                            var walletTransactions: [Transaction] = []
                            for transaction in filteredTrans {
                                walletTransactions.append(transaction.value)
                            }
                            print(walletTransactions)
                            self.walletTransactions = walletTransactions
                        }catch {

                        }
                    }
                }
            }
        }
    }
    
    func getUserInfo() {
        if let user = auth.user {
            db.collection("users").document("\(user.uid)").getDocument { (document, error) in
                
                if let document = document, document.exists {
                    
                    let dataUserInfo = document.data()?.values.map(String.init(describing:))
                    
                    if let jsonData = dataUserInfo![0].data(using: .utf8) {
                        
                        do {
                            let userInfo = try JSONDecoder().decode(UserInfo.self, from: jsonData)
                            self.userInfo = userInfo
                        }catch {

                        }
                    }
                }
            }
        }
    }
    
    func saveTransaction(transactions: [Transaction]) {
        do {
            let encodedData = try JSONEncoder().encode(transactions)
            let jsonString = String(data: encodedData,
                                    encoding: .utf8)
            
            if let user = auth.user {
                db.collection("transactions").document("\(user.uid)").setData(["list_of_transaction": jsonString!]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document transaction written!")
                    }
                }
            }
        }catch {
            
        }
    }
    
    func addBuyHistory(transaction: Transaction) {
        buyHistory.append(transaction)
        do {
            let encodedData = try JSONEncoder().encode(buyHistory)
            let jsonStringBuyHistory = String(data: encodedData,
                                    encoding: .utf8)
            if let user = auth.user {
                db.collection("buy_history").document("\(user.uid)").setData(["list_of_transaction": jsonStringBuyHistory!]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document transaction written!")
                    }
                }
            }
        }catch {
            
        }
    }
    
    func transferTo(receiverID: String, transaction: Transaction) {
        var receiverTransaction: [Transaction] = []
        var receiverBuyHistory: [Transaction] = []
        db.collection("transactions").document("\(receiverID)").getDocument { (document, error) in
            
            if let document = document, document.exists {
                print("In transfer to \(receiverID)")
                let dataTransactions = document.data()?.values.map(String.init(describing:))
                
                if let jsonData = dataTransactions![0].data(using: .utf8) {
                    
                    do {
                        let transactions = try JSONDecoder().decode([Transaction].self, from: jsonData)
                        receiverTransaction = transactions
                        receiverTransaction.append(transaction)
                        self.db.collection("buy_history").document("\(receiverID)").getDocument { (buyHistoryDocument, buyHistoryError) in
                            if let document = buyHistoryDocument, document.exists {
                                
                                let dataTransactions = document.data()?.values.map(String.init(describing:))
                                if let jsonData = dataTransactions![0].data(using: .utf8) {
                                    do {
                                        let transactions = try JSONDecoder().decode([Transaction].self, from: jsonData)
                                        receiverBuyHistory = transactions
                                        receiverBuyHistory.append(transaction)
                                        
                                    }catch {
                                        
                                    }
                                }
                            }
                            self.processReceiverTransaction(receiverTransaction: receiverTransaction, receiverBuyHistory: receiverBuyHistory, receiverID: receiverID)
                        }
                    }catch {

                    }
                }
            }
        }
    }
    
    private func processReceiverTransaction(receiverTransaction: [Transaction], receiverBuyHistory: [Transaction], receiverID: String) {
        do {
            let encodedData = try JSONEncoder().encode(receiverTransaction)
            let jsonStringTransaction = String(data: encodedData,
                                    encoding: .utf8)
            let encodedDataBuyHistory = try JSONEncoder().encode(receiverBuyHistory)
            let jsonStringBuyHistory = String(data: encodedData,
                                    encoding: .utf8)
            db.collection("transactions").document("\(receiverID)").setData(["list_of_transaction": jsonStringTransaction!]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document receiver transaction written!")
                }
            }
            
            db.collection("buy_history").document("\(receiverID)").setData(["list_of_transaction": jsonStringBuyHistory!]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document receiver buy history written!")
                }
            }
        }catch {
            
        }
    }
    
    func addTransaction(transaction: Transaction) {
        transactions.append(transaction)
        buyHistory.append(transaction)
        do {
            let encodedData = try JSONEncoder().encode(transactions)
            let jsonString = String(data: encodedData,
                                    encoding: .utf8)
            
            if let user = auth.user {
                db.collection("transactions").document("\(user.uid)").setData(["list_of_transaction": jsonString!]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        if var user = self.userInfo {
                            let userBalance = Double(user.balance)! - transaction.amount
                            user.balance = String(userBalance)
                            self.saveUserInfo(user: user)
                        }
                        print("Document transaction written!")
                    }
                }
                
                let encodedData = try JSONEncoder().encode(buyHistory)
                let jsonStringBuyHistory = String(data: encodedData,
                                        encoding: .utf8)
                db.collection("buy_history").document("\(user.uid)").setData(["list_of_transaction": jsonStringBuyHistory!]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document transaction written!")
                    }
                }
            }
        }catch {
            
        }
    }
    
    func verifyUser(userId: String, verify: @escaping (Bool) -> Void) {
        db.collection("users").document("\(userId)").getDocument { document, error in
            if let document = document, document.exists {
                print("USer valid")
                verify(true)
            }else {
                verify(false)
            }
        }
    }
}
