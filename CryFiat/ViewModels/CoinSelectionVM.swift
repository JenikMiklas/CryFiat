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
    
    private let coinMarketService = CoinMarketService.shared
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        coinMarketService.$marketCoins
            .sink { [unowned self] (marketCoins) in
                self.marketCoins = marketCoins
            }
            .store(in: &cancellable)
    }
}
