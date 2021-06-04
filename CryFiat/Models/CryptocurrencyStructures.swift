//
//  CryptoCurrency.swift
//  CryFiat
//
//  Created by Jan Miklas on 21.05.2021.
//

import Foundation

struct CryptoCurrencyInfo: Decodable {
  let id: String
  let symbol: String
  let name: String
  let image: URL
  let currentPrice: Double
  let marketCapRank: Int
  let high24H: Double
  let low24H: Double
  let priceChange24H: Double
  let priceChangePercentage24H: Double
  let ath: Double
  let athChangePercentage: Double
  let athDate: String
  let atl: Double
  let atlChangePercentage: Double
  let atlDate: String
  let lastUpdated: String
}

struct Cryptocurrency: Codable, Equatable, Hashable {
  let id: String
  let symbol: String
  let name: String
  var address: [String]?
}

struct CryptoTokenDetail: Codable {
 
  let id: String
  let image: Image


    struct Image: Codable {
      let thumb: String
      let small: String
      let large: String
    }
}


