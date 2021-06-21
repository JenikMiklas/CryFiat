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
    @Published var coinDetail: CoinDetail?
    
    private let localDataService = LocalDataService.shared
    private let coinMarketService = CoinMarketService.shared
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        localDataService.$userCoins
            .sink { [unowned self] coins in
                self.userCoins = coins
            }
            .store(in: &cancellable)
        
        coinMarketService.$coinDetail
            .sink { [unowned self] coinDetail in
                self.coinDetail = coinDetail
                //print(coinDetail)
            }
            .store(in: &cancellable)
    }
    
    func remove(coin: UserCoin) {
        localDataService.removeFromUserList(coin: coin)
    }
    
    func saveUserCoin(coin: CoinsTokenMarket) {
        localDataService.processCoin(coin: coin, address: "no address")
    }
    
    func getCoinDetail(coinID: String) {
        coinMarketService.getCoinDetail(coin: coinID)
    }
}
