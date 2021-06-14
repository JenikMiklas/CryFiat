//
//  CoinSelectionVM.swift
//  CryFiat
//
//  Created by Jan Miklas on 12.06.2021.
//

import Combine
import Foundation

final class CoinSelectionVM: ObservableObject {
    @Published var marketCoins = [CryptoTokenMarket]()
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
    }
    
    func downloadMoreCoins() {
        page += 1
        coinMarketService.getMarketCoins(page: page)
    }
}
