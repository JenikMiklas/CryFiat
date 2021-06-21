//
//  CoinDetailVM.swift
//  CryFiat
//
//  Created by Jan Miklas on 21.06.2021.
//

import Combine
import Foundation
import SwiftUI

class CoinDetailVM: ObservableObject {
    @Published var coinDetail: CoinDetail?
    
    private let localDataService = LocalDataService.shared
    private let fileService = FileService.shared
    private let coinMarketService = CoinMarketService.shared
    private var cancellable = Set<AnyCancellable>()
    
    
    init() {
        coinMarketService.$coinDetail
            .sink { [unowned self] coin in
                self.coinDetail = coin
            }
            .store(in: &cancellable)
    }
    
    func coinImage(coinID: String) -> UIImage {
        return fileService.loadCachedImage(name: coinID) ?? UIImage()
    }
    
    func saveUserCoin(coin: CoinsTokenMarket) {
        localDataService.processCoin(coin: coin, address: "no address")
    }
}
