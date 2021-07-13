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
    @Published var selectedCoin: CoinsTokenMarket? {
        didSet {
            if let coin = selectedCoin {
                price = String(coin.currentPrice * (Double(amount) ?? 1))
                address = getAddress()
            }
        }
    }
    @Published var selectedCurrency = Currency.czk {
        didSet {
            storedCurrency = selectedCurrency
            if !userCoins.isEmpty {
                getSelectedCoins(coinsID: generatePath(coins: userCoins))
            }
        }
    }
    @Published var price: String = "1"
    @Published var amount: String = "1"
    @Published var address = "" {
        didSet {
            processCoin(address: address)
            qrAddress = qrAddress(address: address, amount: amount)
        }
    }
    @Published var qrAddress = ""
    
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
                } else {
                    self.selectedCoin = coins.first(where: { coin in
                        coin.id == self.selectedCoin!.id
                    })
                }
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
        //getChartData(coin: coin.id, currency: currency)
    }
    
    func processCoin(address: String) {
        if let coin = selectedCoin {
            localDataService.processCoin(coin: coin, address: address)
        }
    }
    
    private func getAddress() -> String {
        if let selected = selectedCoin {
            return userCoins.first { coin in
                coin.coinID == selected.id
            }?.address ?? ""
        }
        return ""
    }
    //"ripple:rUwYKnpcDr9PLfE9DzZ6r8P3qpKbqv4SyA?amount=10&message=New house"
    private func qrAddress(address: String, amount: String) -> String {
        if let coin = selectedCoin {
            if coin.id.contains("-") {
                var coindID = coin.id
                for char in coin.id {
                    if char == "-" {
                        let index = coindID.firstIndex(of: char)!
                        coindID.remove(at: index)
                    }
                }
                return coindID + ":" + address + "?amount=" + amount
            }
            return coin.id + ":" + address + "?amount=" + amount
        }
        return ""
    }
    
    func updatePrice(amount: String) {
        let dPrice = (Double(amount) ?? 1) * selectedCoin!.currentPrice
        price = dPrice.priceFormat()
        qrAddress = qrAddress(address: address, amount: amount)
        print(qrAddress)
    }
    
    func updateAmount(price: String) {
        let dAmount = (Double(price) ?? 1) / selectedCoin!.currentPrice
        amount = dAmount.priceFormat()
        qrAddress = qrAddress(address: address, amount: amount)
    }
}
