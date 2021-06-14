//
//  CoinSelectionVM.swift
//  CryFiat
//
//  Created by Jan Miklas on 12.06.2021.
//

import Combine
import Foundation

final class CoinSelectionVM: ObservableObject {
    @Published var marketCoins = [CoinsTokenMarket]() 
    @Published var findCoin = ""
    
    private let coinMarketService = CoinMarketService.shared
    private var cancellable = Set<AnyCancellable>()
    private var page = 1
    
    init() {
        coinMarketService.$marketCoins
            .sink { [unowned self] (marketCoins) in
                self.marketCoins = marketCoins
            }
            .store(in: &cancellable)
        $findCoin
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .removeDuplicates()
            .combineLatest(coinMarketService.$basicCoins)
            .map {(searchCoin, allCoins) -> [BasicCoin] in
                return allCoins.filter {
                    $0.id.lowercased().contains(searchCoin.lowercased()) || $0.name.lowercased().contains(searchCoin.lowercased()) || $0.symbol.lowercased().contains(searchCoin.lowercased())
                }
            }
            .map { coins -> String in
                var string = ""
                for coin in coins {
                    string.append(coin.id)
                    if coins.last != coin {
                        string.append("%2C%20")
                    }
                }
                return  "https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&ids=\(string)&order=market_cap_desc&per_page=250&page=1&sparkline=false"
            }
            .compactMap { [unowned self] in
                self.coinMarketService.getMarketCoins(urlString: $0)
            }
            .sink {}
            .store(in: &cancellable)
    }
    
    func downloadMoreCoins() {
        page += 1
        coinMarketService.getMarketCoins(page: page)
    }
    
    func downloadAllCoins() {
        if coinMarketService.basicCoins.isEmpty {
            coinMarketService.getAllCoins()
        }
    }
}
