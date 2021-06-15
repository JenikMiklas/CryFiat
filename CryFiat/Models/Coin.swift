//
//  Coin.swift
//  CryFiat
//
//  Created by Jan Miklas on 14.06.2021.
//

import Foundation

enum CoinCardSize {
    case small, medium, large
}

struct CoinsTokenMarket: Codable, Equatable, Hashable {
    static func == (lhs: CoinsTokenMarket, rhs: CoinsTokenMarket) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
  struct Roi: Codable, Hashable {
    let times: Double?
    let currency: String?
    let percentage: Double?
  }

  let uuid = UUID().uuidString
  let id: String
  let symbol: String
  let name: String
  let image: String
  let currentPrice: Double
  let marketCap: Double?
  let marketCapRank: Int?
  let fullyDilutedValuation: Double?
  let totalVolume: Double?
  let high24h: Double?
  let low24h: Double?
  let priceChange24h: Double?
  let priceChangePercentage24h: Double?
  let marketCapChange24h: Double?
  let marketCapChangePercentage24h: Double?
  let circulatingSupply: Double?
  let totalSupply: Double?
  let maxSupply: Double?
  let ath: Double?
  let athChangePercentage: Double
  let athDate: String?
  let atl: Double?
  let atlChangePercentage: Double
  let atlDate: String?
  let roi: Roi?
  let lastUpdated: String?

  private enum CodingKeys: String, CodingKey {
    case id
    case symbol
    case name
    case image
    case currentPrice = "current_price"
    case marketCap = "market_cap"
    case marketCapRank = "market_cap_rank"
    case fullyDilutedValuation = "fully_diluted_valuation"
    case totalVolume = "total_volume"
    case high24h = "high_24h"
    case low24h = "low_24h"
    case priceChange24h = "price_change_24h"
    case priceChangePercentage24h = "price_change_percentage_24h"
    case marketCapChange24h = "market_cap_change_24h"
    case marketCapChangePercentage24h = "market_cap_change_percentage_24h"
    case circulatingSupply = "circulating_supply"
    case totalSupply = "total_supply"
    case maxSupply = "max_supply"
    case ath
    case athChangePercentage = "ath_change_percentage"
    case athDate = "ath_date"
    case atl
    case atlChangePercentage = "atl_change_percentage"
    case atlDate = "atl_date"
    case roi
    case lastUpdated = "last_updated"
  }
}

struct BasicCoin: Codable, Equatable, Hashable {
    let id: String
    let symbol: String
    let name: String
}
