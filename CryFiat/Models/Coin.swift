//
//  Coin.swift
//  CryFiat
//
//  Created by Jan Miklas on 14.06.2021.
//

import Foundation
import SwiftUI

enum CoinCardSize: CGFloat {
    case small = 90
    case medium = 135
    case large = 290
}

enum Currency: String, Codable, CaseIterable {
    case btc, eth, ltc, bch, bnb, eos, xrp, xlm, link, dot, yfi, usd, aed, ars, aud, bdt, bhd, bmd, brl, cad, chf, clp, cny, czk, dkk, eur, gbp, hkd, huf, idr, ils, inr, jpy, krw, kwd, lkr, mmk, mxn, myr, ngn, nok, nzd, php, pkr, pln, rub, sar, sek, sgd, thb, twd, uah, vef, vnd, zar, xag, bits
    
    var currencies: [Currency] {
        Self.allCases.sorted { $0.rawValue < $1.rawValue }
    }
    
    var flag: String {
        switch self {
        case .aed:
            return "🇦🇪"
        case .ars:
            return "🇦🇷"
        case .aud:
            return "🇦🇺"
        case .bdt:
            return "🇧🇩"
        case .bhd:
            return "🇧🇭"
        case .bmd:
            return "🇧🇲"
        case .brl:
            return "🇧🇷"
        case .chf:
            return "🇨🇭"
        case .clp:
            return "🇨🇱"
        case .cny:
            return "🇨🇳"
        case .czk:
            return "🇨🇿"
        case .dkk:
            return "🇩🇰"
        case .eur:
            return "🇪🇺"
        case .gbp:
            return "🇬🇧"
        case .hkd:
            return "🇭🇰"
        case .huf:
            return "🇭🇺"
        case .idr:
            return "🇮🇩"
        case .ils:
            return "🇮🇱"
        case .inr:
            return "🇮🇳"
        case .jpy:
            return "🇯🇵"
        case .krw:
            return "🇰🇷"
        case .kwd:
            return "🇰🇼"
        case .lkr:
            return "🇱🇰"
        case .mmk:
            return "🇲🇲"
        case .mxn:
            return "🇲🇽"
        case .myr:
            return "🇲🇾"
        case .ngn:
            return "🇳🇬"
        case .nok:
            return "🇳🇴"
        case .nzd:
            return "🇳🇿"
        case .php:
            return "🇵🇭"
        case .pkr:
            return "🇵🇰"
        case .pln:
            return "🇵🇱"
        case .rub:
            return "🇷🇺"
        case .sar:
            return "🇸🇦"
        case .sek:
            return "🇸🇪"
        case .sgd:
            return "🇸🇬"
        case .thb:
            return "🇹🇭"
        case .twd:
            return "🇹🇼"
        case .uah:
            return "🇺🇦"
        case .usd:
            return "🇺🇸"
        case .vef:
            return "🇻🇪"
        case .vnd:
            return "🇻🇳"
        case .zar:
            return "🇿🇦"
        default:
            return "crypto"
    }
}
    var symbol: String {
        switch self {
        case .btc:
            return "₿"
        case .ltc:
            return "Ł"
        case .aud, .usd, .bmd, .cad, .hkd, .nzd, .sgd, .twd:
            return "$"
        case .eur:
            return "€"
        case .gbp:
            return "£"
        case .inr, .idr, .pkr, .lkr:
            return "₨"
        case .jpy:
            return "¥"
        case .krw:
            return "₩"
        case .ngn:
            return "₦"
        case .php:
            return "₱"
        case .rub:
            return "₽"
        case .thb:
            return "฿"
        default:
            return ""
        }
    }
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

struct ChartData: Codable {
  let prices: [[Double]]
}
