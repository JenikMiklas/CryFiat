//
//  CoinMarketService.swift
//  CryFiat
//
//  Created by Jan Miklas on 12.06.2021.
//

import Combine
import Foundation
import SwiftUI


/// Data to Models.
/// ```
/// Converting data from Download Service to Models.
/// ```
final class CoinMarketService {
    
    static let shared = CoinMarketService()
    
    @Published var marketCoins = [CoinsTokenMarket]()
    @Published var basicCoins = [BasicCoin]()
    @Published var selectedCoins = [CoinsTokenMarket]()
    
    private var subscription: AnyCancellable?
    
    private init() {}
    
    func getMarketCoins(page: Int = 1, currency: Currency) {
           
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=\(currency.rawValue)&order=market_cap_desc&per_page=250&page=\(page)&sparkline=false") else {
             fatalError("Wrong URL to get Top Market Coins")
        }
        subscription = DownloadManager.downloadFrom(url: url)
            .decode(type: [CoinsTokenMarket].self, decoder: JSONDecoder())
            .sink(receiveCompletion: DownloadManager.Completion,
                  receiveValue: { [unowned self] (marketCoins) in
                    if page > 1 {
                        self.marketCoins += marketCoins
                    } else {
                        self.marketCoins = marketCoins
                    }
                    self.subscription?.cancel()
            })
    }
    
    func searchCoins(coins: String, currency: Currency) {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=\(currency.rawValue)&ids=\(coins)&order=market_cap_desc&per_page=250&page=1&sparkline=false") else {
             fatalError("Wrong URL to get Top Market Coins")
        }
        subscription = DownloadManager.downloadFrom(url: url)
            .decode(type: [CoinsTokenMarket].self, decoder: JSONDecoder())
            .sink(receiveCompletion: DownloadManager.Completion,
                  receiveValue: { [unowned self] (marketCoins) in
                    self.marketCoins = marketCoins
                    self.subscription?.cancel()
            })
    }
    
    func getAllCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/list?include_platform=false") else {
             fatalError("Wrong URL to get all Coins")
        }
        subscription = DownloadManager.downloadFrom(url: url)
            .decode(type: [BasicCoin].self, decoder: JSONDecoder())
            .sink(receiveCompletion: DownloadManager.Completion,
                  receiveValue: { [unowned self] (coins) in
                    self.basicCoins = coins
                    print(coins)
                    self.subscription?.cancel()
            })
    }
    
    func getUserCoins(coins: String, currency: Currency) {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=\(currency.rawValue)&ids=\(coins)&order=market_cap_desc&per_page=250&page=1&sparkline=true") else {
             fatalError("Wrong URL to get Top Market Coins")
        }
        subscription = DownloadManager.downloadFrom(url: url)
            .decode(type: [CoinsTokenMarket].self, decoder: JSONDecoder())
            .sink(receiveCompletion: DownloadManager.Completion,
                  receiveValue: { [unowned self] (marketCoins) in
                    self.selectedCoins = marketCoins
                    self.subscription?.cancel()
            })
    }
}
