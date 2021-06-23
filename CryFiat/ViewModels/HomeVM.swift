//
//  HomeVM.swift
//  CryFiat
//
//  Created by Jan Miklas on 19.06.2021.
//

import Combine
import Foundation

class HomeVM: ObservableObject {
    
    @Published var userCoins = [UserCoin]()
    @Published var selectedCoins = [CoinsTokenMarket]()
    @Published var selectedCoin: CoinsTokenMarket?
    
    private let localDataService = LocalDataService.shared
    private let coinMarketService = CoinMarketService.shared
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        localDataService.$userCoins
            .sink { [unowned self] coins in
                self.userCoins = coins
                if !self.userCoins.isEmpty {
                    self.getSelectedCoins(coinsID: generatePath(coins: self.userCoins))
                } else {
                    self.selectedCoins = [CoinsTokenMarket]()
                }
            }
            .store(in: &cancellable)
        
        coinMarketService.$selectedCoins
            .sink { [unowned self] coins in
                self.selectedCoins = coins
            }
            .store(in: &cancellable)
    }
    
    private func generatePath(coins: [UserCoin]) -> String {
        var string = ""
        for coin in coins {
            string.append(coin.coinID!)
            if coins.last != coin {
                string.append("%2C%20")
            }
        }
        return  string
    }
    
    func remove(coin: CoinsTokenMarket) {
        if let index = selectedCoins.firstIndex(where: { $0.id == coin.id }) {
            selectedCoins.remove(at: index)
        }
        if let coinToRemove = userCoins.first(where: { $0.coinID == coin.id }) {
            localDataService.removeFromUserList(coin: coinToRemove)
        }
    }
    
    private func getSelectedCoins(coinsID: String) {
        coinMarketService.getUserCoins(coins: coinsID)
    }
}
