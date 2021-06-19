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
    
    private let localDataService = LocalDataService.shared
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        localDataService.$userCoins
            .sink { [unowned self] coins in
                self.userCoins = coins
            }
            .store(in: &cancellable)
    }
}
