//
//  CoinManager.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 11/09/2023.
//

import Foundation
import Combine
import FirebaseCore
import FirebaseFirestore

class CoinManager {
    @Published var coins: [Coin] = []
    
    var coinSubrciption: AnyCancellable?
    let db = Firestore.firestore()
    
    init() {
        fetchData()
    }
    
    func compareDates(dateString1: String, format: String) -> ComparisonResult? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        
        
        let now = Date()
        let date2_format = dateFormatter.string(from: now)
        print(dateFormatter.date(from: dateString1))
        print(date2_format)
        
        if let date1 = dateFormatter.date(from: dateString1), let date2 = dateFormatter.date(from: date2_format) {
            return date1.compare(date2)
        }else {
            return nil // One or both date strings were invalid
        }
        
        
    }
    
    private func fetchData() {
        let docRef = db.collection("coin_market").document("coins")
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()?.values.map(String.init(describing:))
                let key = document.data()?.keys.map(String.init(describing:))
                let dbDate = key![0].split(separator: ",")[0]
                if let comparisonResult = self.compareDates(dateString1: String(dbDate), format: "MM/dd/yyyy") {
                    switch comparisonResult {
                    case .orderedAscending:
                        print("Fetch from API")
                        fetchFromAPI()
                        break
                    case .orderedSame:


                        // check hour
                        let currentDate = Date()

                        // Create a DateFormatter with the "HH:mm:ss" format
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "HH:mm:ss"

                        if let pastTime = dateFormatter.date(from: String(key![0].split(separator: ",")[1])) {
                            // Extract the hour component from the current time
                            let calendar = Calendar.current
                            let currentHour = calendar.component(.hour, from: currentDate)

                            // Extract the hour component from the past time
                            let pastHour = calendar.component(.hour, from: pastTime)

                            // Calculate the hour difference
                            let hourDifference = currentHour - pastHour

                            if hourDifference == 0 {
                                print("Fetch from Firebase")
                                if let jsonData = dataDescription![0].data(using: .utf8) {
                                    do {
                                        let testing_coins = try JSONDecoder().decode([Coin].self, from: jsonData)
                                        self.coins = testing_coins
                                    }catch {

                                    }
                                }
                            }else {
                                print("Fetch from API")
                                fetchFromAPI()
                            }
                        } else {
                            print("Invalid pastTime format")
                        }



                        break
                    case .orderedDescending:
                        print("Date 1 is later than Date 2")
                    }
                } else {
                    print("One or both date strings are invalid.")
                }
                

                


            } else {
                print("Document does not exist")
            }
    }
    
    func fetchFromAPI() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&locale=en") else {return }
        
        coinSubrciption = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { (output) -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .sink { (completion) in
                
                switch completion {
                case .finished:
                    print("In complete retreive in here")
                    break
                case .failure(let error):
                    print("Error occur")
                    print(error.localizedDescription)
                }
            } receiveValue: {[weak self] coinData in
                print("Here is coinData \(coinData.count)")
                
                do {
                    let db = Firestore.firestore()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "M/dd/yyyy" // Format for the date (e.g., "Sep 13, 2023")
                    
                    let now = Date()
                    let currentUpdateDate = dateFormatter.string(from: now)
                    
                    let dateFormatter_time = DateFormatter()
                    dateFormatter_time.dateFormat = "HH:mm:ss" // Format for the hour, minute, and second
                    let currentHour = dateFormatter_time.string(from: now)
                    
                    let encodedData = try JSONEncoder().encode(coinData)
                    let jsonString = String(data: encodedData,
                                            encoding: .utf8)
                    db.collection("coin_market").document("coins").setData([
                        "\(currentUpdateDate),\(currentHour)": jsonString!
                    ]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                    }
                }catch {
                    
                }
                
                self?.coins = coinData
                self?.coinSubrciption?.cancel()
            }
        }
    }
    
    
    func getCoin(coinId: String) -> Coin? {
        for coin in coins {
            if coin.id == coinId {
                return coin
            }
        }
        return nil
    }
}
