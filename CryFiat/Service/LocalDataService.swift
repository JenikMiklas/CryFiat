//
//  LocalDataService.swift
//  CryFiat
//
//  Created by Jan Miklas on 17.06.2021.
//

import Foundation
import CoreData

final class LocalDataService {
    
    static let shared = LocalDataService()
    
    private let container: NSPersistentContainer
    @Published var userCoins = [UserCoin]()
    
    private init() {
        container = NSPersistentContainer(name: "UserCoins")
        container.loadPersistentStores { (_, error) in
            print("Loading persistent store error.")
            return
        }
        getUserCoins()
    }
    
    
    func processCoin(coin: CoinsTokenMarket, address: String) {
        if let coin = userCoins.first(where: { $0.coinID == coin.id }) {
            updateCoin(coin: coin, address: address)
        } else {
            saveCoin(coin: coin, address: address)
        }
    }
    
    func getUserCoins() {
        let request = NSFetchRequest<UserCoin>(entityName: "UserCoin")
        
        do {
            userCoins = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching Coins \(error.localizedDescription)")
        }
    }
    
    private func updateCoin(coin: UserCoin, address: String) {
        coin.address = address
        reload()
    }
    
    private func saveCoin(coin: CoinsTokenMarket, address: String) {
        let userCoin = UserCoin(context: container.viewContext)
        userCoin.address = address
        userCoin.coinID = coin.id
        reload()
    }
    
    private func delete(coin: CoinsTokenMarket) {
        if let coin = userCoins.first(where: { $0.coinID == coin.id }) {
            container.viewContext.delete(coin)
            reload()
        }
    }
    
    private func reload() {
        save()
        getUserCoins()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving context: \(error.localizedDescription)")
        }
    }
}
