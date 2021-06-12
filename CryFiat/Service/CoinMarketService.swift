//
//  CoinMarketService.swift
//  CryFiat
//
//  Created by Jan Miklas on 12.06.2021.
//

import Combine
import Foundation
import SwiftUI

final class CoinMarketService {
    
    static let shared = CoinMarketService()
    
    @Published var marketCoins = [CryptoTokenMarket]()
    
    private var page = 1
    private var subscription: AnyCancellable?
    
    private init() { getMarketCoins() }
    
    private func getMarketCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=250&page=\(page)&sparkline=false") else {
             fatalError("Wrong URL to get Top Market Coins")
        }
        subscription = DownloadManager.downloadFrom(url: url)
            .decode(type: [CryptoTokenMarket].self, decoder: JSONDecoder())
            .sink(receiveCompletion: DownloadManager.Completion,
                  receiveValue: { [unowned self] (marketCoins) in
                self.marketCoins = marketCoins
                self.subscription?.cancel()
            })
    }
}
