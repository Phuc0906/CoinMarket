//
//  UserManager.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 18/09/2023.
//

/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Hoang Phuc
  ID: s3879362
  Created  date: 18/09/2023
  Last modified: 18/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import Foundation
import Firebase
import FirebaseAuth
import SwiftUI
class UserManager: ObservableObject {
    
    @Published var transactions: [Transaction] = []
    @Published var buyHistory: [Transaction] = []
    @Published var wallet: [String:Transaction] = [:]
    @Published var userInfo: UserInfo?
    @Published var walletTransactions: [Transaction] = []
    @Published var holdings: ChartDataModel?
    @Published var userAssets: ChartDataModel?
    @Published var language = false
    let coinManager = CoinManager()
    private var auth = AuthViewModel()
    let db = Firestore.firestore()
    private var user: User?
    var receiverValidation = false
    
    init() {
        
        Auth.auth().addStateDidChangeListener { auth, user in
            self.user = user
            self.getTransactions()
            self.getUserInfo() {
                self.getWallet()
            }
            self.getBuyHistory()
            //self.getWallet()
        }
    }
    
    // MARK: get user holdings
    func getWallet() {
        if let user = auth.user {
            self.db.collection("wallet").document("\(user.uid)").getDocument { (document, error) in
                
                if let document = document, document.exists {
                    
                    let dataTransactions = document.data()?.values.map(String.init(describing:))
                    
                    if let jsonData = dataTransactions![0].data(using: .utf8) {
                        
                        do {
                            let wallet = try JSONDecoder().decode([String:Transaction].self, from: jsonData)
                            
                            self.wallet = wallet
                            print(wallet)
                            self.getHoldings(wallet: wallet)
                            self.getUserAssets(wallet: wallet)
                        }catch {
                            
                        }
                    }
                }
            }
        }
    }
    
    // MARK: get all user on databasee
    private func getAllUsers() {
        db.collection("users").document()
    }
    
    // MARK: update user info
    func saveUserInfo(user: UserInfo, complete: (() -> Void)? = nil) {
        do {
            let encodedData = try JSONEncoder().encode(user)
            let jsonString = String(data: encodedData,
                                    encoding: .utf8)
            db.collection("users").document("\(user.id)").setData(["profile": jsonString!]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                    complete?()
                } else {
                    print("Document user written!")
                    complete?()
                }
            }
        }catch {
            
        }
    }
    
    func getUserBuyHistory(userID: String, complete: ((_ transactions: [Transaction]) -> Void)? = nil) {
        db.collection("buy_history").document("\(userID)").getDocument { (document, error) in
            
            if let document = document, document.exists {
                
                let dataTransactions = document.data()?.values.map(String.init(describing:))
                
                if let jsonData = dataTransactions![0].data(using: .utf8) {
                    do {
                        let transactions = try JSONDecoder().decode([Transaction].self, from: jsonData)
                        self.buyHistory = transactions
                        complete?(transactions)
                    }catch {
                        
                    }
                }
            }
        }
    }
    
    func getBuyHistory() {
        if let user = auth.user {
            print("In us manager \(user.uid)")
            self.db.collection("buy_history").document("\(user.uid)").getDocument { (document, error) in
                
                if let document = document, document.exists {
                    
                    let dataTransactions = document.data()?.values.map(String.init(describing:))
                    
                    if let jsonData = dataTransactions![0].data(using: .utf8) {
                        do {
                            let transactions = try JSONDecoder().decode([Transaction].self, from: jsonData)
                            self.buyHistory = transactions
                            print("In user buy history")
                        }catch {
                            
                        }
                    }
                }
            }
        }
    }
    
    func getFilteredTransaction() -> [Transaction] {
        var localWallet: [Transaction] = []
        for transaction in wallet {
            localWallet.append(transaction.value)
        }
        return localWallet
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
    
    func getUserInfo(completion: @escaping () -> Void) {
        if let user = auth.user {
            db.collection("users").document("\(user.uid)").getDocument { (document, error) in
                
                if let document = document, document.exists {
                    
                    let dataUserInfo = document.data()?.values.map(String.init(describing:))
                    
                    if let jsonData = dataUserInfo![0].data(using: .utf8) {
                        
                        do {
                            let userInfo = try JSONDecoder().decode(UserInfo.self, from: jsonData)
                            self.userInfo = userInfo
                            completion()
                        }catch {
                            
                        }
                    }
                }
            }
        }
    }
    
    func saveTransaction(amount: Double, transaction: Transaction, coins: [Coin], buyHistoryTransaction: Transaction, receiverID: String, receiverTransaction: Transaction, complete: (() -> Void)? = nil) {
        // find current coin
        var transferCoin: Coin?
        for coin in coins {
            if coin.id == transaction.coinId {
                transferCoin = coin
                break
            }
        }
        
        if let coin = transferCoin {
            var localWallet = self.wallet

            for var walletTransaction in localWallet {
                if walletTransaction.value.coinId == transaction.coinId {
                    localWallet[walletTransaction.key]?.amount -= coin.current_price*abs(amount)
                    localWallet[walletTransaction.key]?.numberOfCoin -= abs(amount)
                    print("Reach wallet \(walletTransaction.value.coinId) - \(transaction.numberOfCoin)")
                    break
                }
            }
            print(localWallet)
            
            do {
                let encodedData = try JSONEncoder().encode(localWallet)
                let jsonString = String(data: encodedData,
                                        encoding: .utf8)
                
                if let user = auth.user {
                    db.collection("wallet").document("\(user.uid)").setData(["list_of_transaction": jsonString!]) { err in
                        if let err = err {
                            print("Error Saving Transaction document: \(err)")
                        } else {
                            print("Save wallet transaction written!")
                            self.addBuyHistory(transaction: buyHistoryTransaction) {
                                self.transferTo(receiverID: receiverID, transaction: receiverTransaction, coins: coins,complete: {
                                    self.getUserInfo() {
                                        self.getWallet()
                                    }
                                    self.getBuyHistory()
                                    complete?()
                                })
                            }
                        }
                    }
                }
            }catch {
                
            }
        }
        
        
    }
    
    // MARK: save user transaction
    func addBuyHistory(transaction: Transaction, complete: (() -> Void)? = nil) {
        buyHistory.append(transaction)
        do {
            let encodedData = try JSONEncoder().encode(buyHistory)
            let jsonStringBuyHistory = String(data: encodedData,
                                              encoding: .utf8)
            if let user = auth.user {
                db.collection("buy_history").document("\(user.uid)").setData(["list_of_transaction": jsonStringBuyHistory!]) { err in
                    if let err = err {
                        print("Error in writing buy history document: \(err)")
                    } else {
                        print("Buy history transaction written!")
                        
                        complete?()
                        
                    }
                }
            }
        }catch {
            
        }
    }
    
    // MARK: check if user are holding coin or not
    func isHadCoin(coinID: String) -> Bool {
        for transaction in buyHistory {
            if transaction.coinId == coinID {
                return true
            }
        }
        
        return false
    }
    
    // MARK: sell all user's coin
    func sellAll(coinID: String) {
        var currentCoin = coinManager.getCoin(coinId: coinID)
        
        
        if let coin = currentCoin {
            var localWallet = self.wallet
            var transactionKey = ""
            for transaction in localWallet {
                if transaction.value.coinId == coinID {
                    // reset transaction
                    self.userInfo?.balance = String(Double(self.userInfo?.balance ?? "0.0")! + (localWallet[transaction.key]?.numberOfCoin ?? 0.0)*coin.current_price)
                    transactionKey = transaction.key
                    break
                }
            }
            self.saveBuyHistory(transaction: Transaction(coinId: localWallet[transactionKey]?.coinId ?? "", userId: localWallet[transactionKey]?.userId ?? "", currentPrice: currentCoin?.current_price ?? 0.0, numberOfCoin: localWallet[transactionKey]?.numberOfCoin ?? 0.0, transactionDate: Date()))
            
            localWallet.removeValue(forKey: transactionKey)
            self.saveWallet(wallet: localWallet)
            saveUserInfo(user: self.userInfo!)
            
        }
    }
    
    func getUserHolding(coinID: String, userWallet: [String:Transaction]) -> Double {
        for transaction in userWallet {
            if transaction.value.coinId == coinID {
                return transaction.value.numberOfCoin
            }
        }
        return 0.0
    }
    
    // MARK: save user buy history
    func saveBuyHistory(transaction: Transaction) {
        do {
            if let user = auth.user {
                let encodedDataBuyHistory = try JSONEncoder().encode(self.buyHistory)
                let jsonStringBuyHistory = String(data: encodedDataBuyHistory,
                                                  encoding: .utf8)
                self.db.collection("buy_history").document("\(user.uid)").setData(["list_of_transaction": jsonStringBuyHistory!]) { err in
                    if let err = err {
                        print("Error writing sell document: \(err)")
                    } else {
                        print("Document transaction sell written!")
                        self.getUserInfo() {
                            self.getWallet()
                        }
                        self.getBuyHistory()
                    }
                }
            }
        }catch {
            
        }
    }
    
    // MARK: save user's holdings
    func saveWallet(wallet: [String:Transaction]) {
        
        do {
            let encodedData = try JSONEncoder().encode(wallet)
            let jsonString = String(data: encodedData,
                                    encoding: .utf8)
            
            if let user = auth.user {
                db.collection("wallet").document("\(user.uid)").setData(["list_of_transaction": jsonString!]) { err in
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
    
    // MARK: sell an amount of coin
    func sell(transaction: Transaction, complete: (() -> Void)? = nil) {
        self.buyHistory.append(transaction)
        var localWallet = self.wallet
        for var localTransaction in localWallet {
            if localTransaction.value.coinId == transaction.coinId {
                localWallet[localTransaction.key]?.amount -= transaction.amount // this amount is negative
                localWallet[localTransaction.key]?.numberOfCoin -= abs(transaction.numberOfCoin)
                self.userInfo?.balance = String(Double(self.userInfo?.balance ?? "0.0")! + abs(transaction.amount))
                break
            }
        }
        print(localWallet)
        saveUserInfo(user: self.userInfo!)
        if let user = auth.user {
            do {
                let encodedData = try JSONEncoder().encode(localWallet)
                let jsonString = String(data: encodedData,
                                        encoding: .utf8)
                
                if let user = auth.user {
                    db.collection("wallet").document("\(user.uid)").setData(["list_of_transaction": jsonString!]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document transaction written!")
                        }
                    }
                }
                
                let encodedDataBuyHistory = try JSONEncoder().encode(buyHistory)
                let jsonStringBuyHistory = String(data: encodedDataBuyHistory,
                                                  encoding: .utf8)
                db.collection("buy_history").document("\(user.uid)").setData(["list_of_transaction": jsonStringBuyHistory!]) { err in
                    if let err = err {
                        print("Error writing sell document: \(err)")
                    } else {
                        print("Document transaction sell written!")
                        self.getUserInfo() {
                            self.getWallet()
                        }
                        self.getBuyHistory()
                        complete?()
                    }
                }
            }catch {
                
            }
        }
        
        
    }
    
    // MARK: transfer coin to other user
    func transferTo(receiverID: String, transaction: Transaction, coins: [Coin], complete: (() -> Void)? = nil) {
        var transferCoin: Coin?
        for coin in coins {
            if coin.id == transaction.coinId {
                transferCoin = coin
                break
            }
        }
        
        var receiverWallet: [String:Transaction] = [:]
        var receiverBuyHistory: [Transaction] = []
        db.collection("wallet").document("\(receiverID)").getDocument { (document, error) in
            
            if let document = document, document.exists {
                let dataTransactions = document.data()?.values.map(String.init(describing:))
                
                if let jsonData = dataTransactions![0].data(using: .utf8) {
                    
                    do {
                        let transactions = try JSONDecoder().decode([String:Transaction].self, from: jsonData)
                        receiverWallet = transactions
                        
                        var isFound = false
                        if let coin = transferCoin {
                            for var localTransaction in receiverWallet {
                                if localTransaction.value.coinId == transaction.coinId {
                                    localTransaction.value.amount += coin.current_price*transaction.numberOfCoin
                                    localTransaction.value.numberOfCoin += transaction.numberOfCoin
                                    isFound = true
                                    break
                                }
                            }
                            
                            if !isFound {
                                receiverWallet[transaction.coinId] = transaction
                            }
                        }
                        
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
                            self.processReceiverTransaction(receiverWallet: receiverWallet, receiverBuyHistory: receiverBuyHistory, receiverID: receiverID) {
                                print("Run in transfer to")
                                complete?()
                            }
                        }
                    }catch {
                        
                    }
                }
            }else {
                receiverWallet[transaction.coinId] = transaction
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
                    }else {
                        receiverBuyHistory.append(transaction)
                    }
                    self.processReceiverTransaction(receiverWallet: receiverWallet, receiverBuyHistory: receiverBuyHistory, receiverID: receiverID) {
                        print("Run in transfer to")
                        complete?()
                    }
                }
            }
        }
    }
    
    // MARK: save receiver holding and transaction after receiving coin
    private func processReceiverTransaction(receiverWallet: [String:Transaction], receiverBuyHistory: [Transaction], receiverID: String, complete: (() -> Void)? = nil) {
        do {
            let encodedData = try JSONEncoder().encode(receiverWallet)
            let jsonStringTransaction = String(data: encodedData,
                                               encoding: .utf8)
            let encodedDataBuyHistory = try JSONEncoder().encode(receiverBuyHistory)
            let jsonStringBuyHistory = String(data: encodedData,
                                              encoding: .utf8)
            db.collection("wallet").document("\(receiverID)").setData(["list_of_transaction": jsonStringTransaction!]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document receiver transaction written!")
                    self.db.collection("buy_history").document("\(receiverID)").setData(["list_of_transaction": jsonStringBuyHistory!]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document receiver buy history written!")
                            complete?()
                        }
                    }
                }
            }
            
            
        }catch {
            
        }
    }
    
    
    func addTransaction(transaction: Transaction, complete: (() -> Void)? = nil) {
        var localWallet = self.wallet
        var isFound = false
        for var walletTransaction in localWallet {
            if walletTransaction.value.coinId == transaction.coinId {
                localWallet[walletTransaction.key]?.numberOfCoin += transaction.numberOfCoin
                localWallet[walletTransaction.key]?.amount += transaction.amount
                isFound = true
                break
            }
        }
        
        if !isFound {
            localWallet[transaction.coinId] = transaction
        }
        
        //        transactions.append(transaction)
        buyHistory.append(transaction)
        do {
            let encodedData = try JSONEncoder().encode(localWallet)
            let jsonString = String(data: encodedData,
                                    encoding: .utf8)
            
            if let user = auth.user {
                db.collection("wallet").document("\(user.uid)").setData(["list_of_wallet": jsonString!]) { err in
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
                        complete?()
                        self.getUserInfo() {
                            self.getWallet()
                        }
                        self.getBuyHistory()
                    }
                }
            }
        }catch {
            
        }
    }
    
    // MARK: this use for sketching a graph
    func getHoldings(wallet: [String:Transaction]) {
        var colors: [Color] = []
        var chartCellModels: [ChartCellModel] = []
        var randomColor: Color
        print("In holding wallet: \(wallet.count)")
        for var transaction in wallet {
            repeat {
                randomColor = Color(
                    
                    red: .random(in: 0...1),
                    
                    green: .random(in: 0...1),
                    
                    blue: .random(in: 0...1)
                    
                )
                
            } while colors.contains(randomColor)
            
            colors.append(randomColor)
            if let currentCoin = coinManager.getCoin(coinId: transaction.value.coinId) {
                print("coin: \(currentCoin)")
                chartCellModels.append(ChartCellModel(color: randomColor, name: currentCoin.name, amount: Double(transaction.value.numberOfCoin * currentCoin.current_price)))
            }
        }
        print("In holdings \(chartCellModels.count)")
        self.holdings = ChartDataModel(dataModel: chartCellModels)
    }
    
    func getUserAssets(wallet: [String:Transaction]) {
        var chartCellModels: [ChartCellModel] = []
        var coinValue: Double = 0.0
        for var transaction in wallet {
            if let currentCoin = coinManager.getCoin(coinId: transaction.value.coinId) {
                coinValue += transaction.value.numberOfCoin * currentCoin.current_price
            }
        }
        chartCellModels.append(ChartCellModel(color: .red, name: "Coin", amount: Double(coinValue)))
        if let user = self.userInfo {
            chartCellModels.append(ChartCellModel(color: .blue, name: "Money", amount: Double(user.balance) ?? 0.0))
        }
        self.userAssets = ChartDataModel(dataModel: chartCellModels)
    }
    
    // MARK: verify when receiver id
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
