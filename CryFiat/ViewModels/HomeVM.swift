//
//  HomeVM.swift
//  CryFiat
//
//  Created by Jan Miklas on 19.06.2021.
//

import Combine
import Foundation
import SwiftUI

class HomeVM: ObservableObject {
    
    @Published var userCoins = [UserCoin]()
    @Published var selectedCoins = [CoinsTokenMarket]()
    @Published var selectedCoin: CoinsTokenMarket?
    @Published var chartData: [Double]?
    @Published var selectedCurrency = Currency.czk {
        didSet {
            storedCurrency = selectedCurrency
            if !userCoins.isEmpty {
                getSelectedCoins(coinsID: generatePath(coins: userCoins))
                print("změna fiat")
            }
        }
    }
    @AppStorage("currency") var storedCurrency = Currency.eur
    
    private let localDataService = LocalDataService.shared
    private let coinMarketService = CoinMarketService.shared
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        selectedCurrency = storedCurrency
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
                if !coins.isEmpty && self.selectedCoin == nil {
                    self.selectedCoin = coins.first!
                }
            }
            .store(in: &cancellable)
        
        coinMarketService.$chartData
            .sink { [unowned self] chartData in
                self.chartData = chartData
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
    
    private func getSelectedCoins(coinsID: String) {
        coinMarketService.getUserCoins(coins: coinsID, currency: selectedCurrency)
    }
    
    func getChartData(coin: String, currency: Currency) {
        coinMarketService.getChartData(coin: coin, currency: currency)
    }
    
    func remove(coin: CoinsTokenMarket) {
        if let index = selectedCoins.firstIndex(where: { $0.id == coin.id }) {
            selectedCoins.remove(at: index)
            if let coinToRemove = userCoins.first(where: { $0.coinID == coin.id }) {
                localDataService.removeFromUserList(coin: coinToRemove)
            }
        }
        if selectedCoins.isEmpty { selectedCoin = nil }
    }
    
    func getCoinData(coin: CoinsTokenMarket, currency: Currency) {
        selectedCoin = coin
        getChartData(coin: coin.id, currency: currency)
    }
}
