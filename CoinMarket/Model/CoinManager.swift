//
//  CoinManager.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 11/09/2023.
//

import Foundation
import Combine

class CoinManager {
    @Published var coins: [Coin] = []
    
    var coinSubrciption: AnyCancellable?
    
    init() {
        fetchData()
    }
    
    private func fetchData() {
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
//                print(coinData)
                self?.coins = coinData
                self?.coinSubrciption?.cancel()
            }

    }
}
