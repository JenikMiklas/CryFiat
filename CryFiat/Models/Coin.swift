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
    case large = 320
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

struct CoinDetail: Codable {
    let id: String
      let symbol: String
      let name: String
      let publicNotice: String?
      let localization: Localization
      let description: Description
      let links: Link
      let image: Image
      let sentimentVotesUpPercentage: Double
      let sentimentVotesDownPercentage: Double
      let marketCapRank: Int
      let publicInterestScore: Double
      let marketData: MarketData
      let lastUpdated: String

      private enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case publicNotice = "public_notice"
        case localization
        case description
        case links
        case image
        case sentimentVotesUpPercentage = "sentiment_votes_up_percentage"
        case sentimentVotesDownPercentage = "sentiment_votes_down_percentage"
        case marketCapRank = "market_cap_rank"
        case publicInterestScore = "public_interest_score"
        case marketData = "market_data"
        case lastUpdated = "last_updated"
      }
    
    struct Localization: Codable {
      let en: String
      let de: String
      let es: String
      let fr: String
      let it: String
      let pl: String
      let ro: String
      let hu: String
      let nl: String
      let pt: String
      let sv: String
      let vi: String
      let tr: String
      let ru: String
      let ja: String
      let zh: String
      let zhTw: String
      let ko: String
      let ar: String
      let th: String
      let id: String

      private enum CodingKeys: String, CodingKey {
        case en
        case de
        case es
        case fr
        case it
        case pl
        case ro
        case hu
        case nl
        case pt
        case sv
        case vi
        case tr
        case ru
        case ja
        case zh
        case zhTw = "zh-tw"
        case ko
        case ar
        case th
        case id
      }
    }
    struct Description: Codable {
      let en: String
      let de: String
      let es: String
      let fr: String
      let it: String
      let pl: String
      let ro: String
      let hu: String
      let nl: String
      let pt: String
      let sv: String
      let vi: String
      let tr: String
      let ru: String
      let ja: String
      let zh: String
      let zhTw: String
      let ko: String
      let ar: String
      let th: String
      let id: String

      private enum CodingKeys: String, CodingKey {
        case en
        case de
        case es
        case fr
        case it
        case pl
        case ro
        case hu
        case nl
        case pt
        case sv
        case vi
        case tr
        case ru
        case ja
        case zh
        case zhTw = "zh-tw"
        case ko
        case ar
        case th
        case id
      }
    }
    struct Link: Codable {
      let homepage: [String]?
      

      private enum CodingKeys: String, CodingKey {
        case homepage
      }
    }
    struct Image: Codable {
      let thumb: String
      let small: String
      let large: String
    }
    
    struct MarketData: Codable {
      let currentPrice: CurrentPrice
      
      let ath: Ath
      let athChangePercentage: AthChangePercentage
      let athDate: AthDate
      let atl: Atl
      let atlChangePercentage: AtlChangePercentage
      let atlDate: AtlDate
      let marketCap: MarketCap
      let marketCapRank: Int
      
      let totalVolume: TotalVolume
      let high24h: High24h
      let low24h: Low24h
      let priceChange24h: Double
      let priceChangePercentage24h: Double
      let priceChangePercentage7d: Double
      let priceChangePercentage14d: Double
      let priceChangePercentage30d: Double
      let priceChangePercentage60d: Double
      let priceChangePercentage200d: Double
      let priceChangePercentage1y: Double
      let marketCapChange24h: Double
      let marketCapChangePercentage24h: Double
      let priceChange24hInCurrency: PriceChange24hInCurrency
      let priceChangePercentage1hInCurrency: PriceChangePercentage1hInCurrency
      let priceChangePercentage24hInCurrency: PriceChangePercentage24hInCurrency
      let priceChangePercentage7dInCurrency: PriceChangePercentage7dInCurrency
      let priceChangePercentage14dInCurrency: PriceChangePercentage14dInCurrency
      let priceChangePercentage30dInCurrency: PriceChangePercentage30dInCurrency
      let priceChangePercentage60dInCurrency: PriceChangePercentage60dInCurrency
      let priceChangePercentage200dInCurrency: PriceChangePercentage200dInCurrency
      let priceChangePercentage1yInCurrency: PriceChangePercentage1yInCurrency
      let marketCapChange24hInCurrency: MarketCapChange24hInCurrency
      let marketCapChangePercentage24hInCurrency: MarketCapChangePercentage24hInCurrency
      let totalSupply: Int
     
      let circulatingSupply: Int
      let lastUpdated: String

      private enum CodingKeys: String, CodingKey {
        case currentPrice = "current_price"
        
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        
        case totalVolume = "total_volume"
        case high24h = "high_24h"
        case low24h = "low_24h"
        case priceChange24h = "price_change_24h"
        case priceChangePercentage24h = "price_change_percentage_24h"
        case priceChangePercentage7d = "price_change_percentage_7d"
        case priceChangePercentage14d = "price_change_percentage_14d"
        case priceChangePercentage30d = "price_change_percentage_30d"
        case priceChangePercentage60d = "price_change_percentage_60d"
        case priceChangePercentage200d = "price_change_percentage_200d"
        case priceChangePercentage1y = "price_change_percentage_1y"
        case marketCapChange24h = "market_cap_change_24h"
        case marketCapChangePercentage24h = "market_cap_change_percentage_24h"
        case priceChange24hInCurrency = "price_change_24h_in_currency"
        case priceChangePercentage1hInCurrency = "price_change_percentage_1h_in_currency"
        case priceChangePercentage24hInCurrency = "price_change_percentage_24h_in_currency"
        case priceChangePercentage7dInCurrency = "price_change_percentage_7d_in_currency"
        case priceChangePercentage14dInCurrency = "price_change_percentage_14d_in_currency"
        case priceChangePercentage30dInCurrency = "price_change_percentage_30d_in_currency"
        case priceChangePercentage60dInCurrency = "price_change_percentage_60d_in_currency"
        case priceChangePercentage200dInCurrency = "price_change_percentage_200d_in_currency"
        case priceChangePercentage1yInCurrency = "price_change_percentage_1y_in_currency"
        case marketCapChange24hInCurrency = "market_cap_change_24h_in_currency"
        case marketCapChangePercentage24hInCurrency = "market_cap_change_percentage_24h_in_currency"
        case totalSupply = "total_supply"
        
        case circulatingSupply = "circulating_supply"
        case lastUpdated = "last_updated"
      }
        struct CurrentPrice: Codable {
          let aed: Double
          let ars: Double
          let aud: Double
          let bch: Double
          let bdt: Double
          let bhd: Double
          let bmd: Double
          let bnb: Double
          let brl: Double
          let btc: Double
          let cad: Double
          let chf: Double
          let clp: Double
          let cny: Double
          let czk: Double
          let dkk: Double
          let dot: Double
          let eos: Double
          let eth: Double
          let eur: Double
          let gbp: Double
          let hkd: Double
          let huf: Double
          let idr: Double
          let ils: Double
          let inr: Double
          let jpy: Double
          let krw: Double
          let kwd: Double
          let lkr: Double
          let ltc: Double
          let mmk: Double
          let mxn: Double
          let myr: Double
          let ngn: Double
          let nok: Double
          let nzd: Double
          let php: Double
          let pkr: Double
          let pln: Double
          let rub: Double
          let sar: Double
          let sek: Double
          let sgd: Double
          let thb: Double
          let `try`: Double
          let twd: Double
          let uah: Double
          let usd: Double
          let vef: Double
          let vnd: Double
          let xag: Double
          let xau: Double
          let xdr: Double
          let xlm: Double
          let xrp: Double
          let yfi: Double
          let zar: Double
          let bits: Double
          let link: Double
          let sats: Double
        }

        struct Ath: Codable {
          let aed: Double
          let ars: Double
          let aud: Double
          let bch: Double
          let bdt: Double
          let bhd: Double
          let bmd: Double
          let bnb: Double
          let brl: Double
          let btc: Double
          let cad: Double
          let chf: Double
          let clp: Double
          let cny: Double
          let czk: Double
          let dkk: Double
          let dot: Double
          let eos: Double
          let eth: Double
          let eur: Double
          let gbp: Double
          let hkd: Double
          let huf: Double
          let idr: Double
          let ils: Double
          let inr: Double
          let jpy: Double
          let krw: Double
          let kwd: Double
          let lkr: Double
          let ltc: Double
          let mmk: Double
          let mxn: Double
          let myr: Double
          let ngn: Double
          let nok: Double
          let nzd: Double
          let php: Double
          let pkr: Double
          let pln: Double
          let rub: Double
          let sar: Double
          let sek: Double
          let sgd: Double
          let thb: Double
          let `try`: Double
          let twd: Double
          let uah: Double
          let usd: Double
          let vef: Double
          let vnd: Double
          let xag: Double
          let xau: Double
          let xdr: Double
          let xlm: Double
          let xrp: Double
          let yfi: Double
          let zar: Double
          let bits: Double
          let link: Double
          let sats: Double
        }
        struct AthChangePercentage: Codable {
          let aed: Double
          let ars: Double
          let aud: Double
          let bch: Double
          let bdt: Double
          let bhd: Double
          let bmd: Double
          let bnb: Double
          let brl: Double
          let btc: Double
          let cad: Double
          let chf: Double
          let clp: Double
          let cny: Double
          let czk: Double
          let dkk: Double
          let dot: Double
          let eos: Double
          let eth: Double
          let eur: Double
          let gbp: Double
          let hkd: Double
          let huf: Double
          let idr: Double
          let ils: Double
          let inr: Double
          let jpy: Double
          let krw: Double
          let kwd: Double
          let lkr: Double
          let ltc: Double
          let mmk: Double
          let mxn: Double
          let myr: Double
          let ngn: Double
          let nok: Double
          let nzd: Double
          let php: Double
          let pkr: Double
          let pln: Double
          let rub: Double
          let sar: Double
          let sek: Double
          let sgd: Double
          let thb: Double
          let `try`: Double
          let twd: Double
          let uah: Double
          let usd: Double
          let vef: Double
          let vnd: Double
          let xag: Double
          let xau: Double
          let xdr: Double
          let xlm: Double
          let xrp: Double
          let yfi: Double
          let zar: Double
          let bits: Double
          let link: Double
          let sats: Double
        }

        struct AthDate: Codable {
          let aed: String
          let ars: String
          let aud: String
          let bch: String
          let bdt: String
          let bhd: String
          let bmd: String
          let bnb: String
          let brl: String
          let btc: String
          let cad: String
          let chf: String
          let clp: String
          let cny: String
          let czk: String
          let dkk: String
          let dot: String
          let eos: String
          let eth: String
          let eur: String
          let gbp: String
          let hkd: String
          let huf: String
          let idr: String
          let ils: String
          let inr: String
          let jpy: String
          let krw: String
          let kwd: String
          let lkr: String
          let ltc: String
          let mmk: String
          let mxn: String
          let myr: String
          let ngn: String
          let nok: String
          let nzd: String
          let php: String
          let pkr: String
          let pln: String
          let rub: String
          let sar: String
          let sek: String
          let sgd: String
          let thb: String
          let `try`: String
          let twd: String
          let uah: String
          let usd: String
          let vef: String
          let vnd: String
          let xag: String
          let xau: String
          let xdr: String
          let xlm: String
          let xrp: String
          let yfi: String
          let zar: String
          let bits: String
          let link: String
          let sats: String
        }

        struct Atl: Codable {
          let aed: Double
          let ars: Double
          let aud: Double
          let bch: Double
          let bdt: Double
          let bhd: Double
          let bmd: Double
          let bnb: Double
          let brl: Double
          let btc: Double
          let cad: Double
          let chf: Double
          let clp: Double
          let cny: Double
          let czk: Double
          let dkk: Double
          let dot: Double
          let eos: Double
          let eth: Double
          let eur: Double
          let gbp: Double
          let hkd: Double
          let huf: Double
          let idr: Double
          let ils: Double
          let inr: Double
          let jpy: Double
          let krw: Double
          let kwd: Double
          let lkr: Double
          let ltc: Double
          let mmk: Double
          let mxn: Double
          let myr: Double
          let ngn: Double
          let nok: Double
          let nzd: Double
          let php: Double
          let pkr: Double
          let pln: Double
          let rub: Double
          let sar: Double
          let sek: Double
          let sgd: Double
          let thb: Double
          let `try`: Double
          let twd: Double
          let uah: Double
          let usd: Double
          let vef: Double
          let vnd: Double
          let xag: Double
          let xau: Double
          let xdr: Double
          let xlm: Double
          let xrp: Double
          let yfi: Double
          let zar: Double
          let bits: Double
          let link: Double
          let sats: Double
        }

        struct AtlChangePercentage: Codable {
          let aed: Double
          let ars: Double
          let aud: Double
          let bch: Double
          let bdt: Double
          let bhd: Double
          let bmd: Double
          let bnb: Double
          let brl: Double
          let btc: Double
          let cad: Double
          let chf: Double
          let clp: Double
          let cny: Double
          let czk: Double
          let dkk: Double
          let dot: Double
          let eos: Double
          let eth: Double
          let eur: Double
          let gbp: Double
          let hkd: Double
          let huf: Double
          let idr: Double
          let ils: Double
          let inr: Double
          let jpy: Double
          let krw: Double
          let kwd: Double
          let lkr: Double
          let ltc: Double
          let mmk: Double
          let mxn: Double
          let myr: Double
          let ngn: Double
          let nok: Double
          let nzd: Double
          let php: Double
          let pkr: Double
          let pln: Double
          let rub: Double
          let sar: Double
          let sek: Double
          let sgd: Double
          let thb: Double
          let `try`: Double
          let twd: Double
          let uah: Double
          let usd: Double
          let vef: Double
          let vnd: Double
          let xag: Double
          let xau: Double
          let xdr: Double
          let xlm: Double
          let xrp: Double
          let yfi: Double
          let zar: Double
          let bits: Double
          let link: Double
          let sats: Double
        }

        struct AtlDate: Codable {
          let aed: String
          let ars: String
          let aud: String
          let bch: String
          let bdt: String
          let bhd: String
          let bmd: String
          let bnb: String
          let brl: String
          let btc: String
          let cad: String
          let chf: String
          let clp: String
          let cny: String
          let czk: String
          let dkk: String
          let dot: String
          let eos: String
          let eth: String
          let eur: String
          let gbp: String
          let hkd: String
          let huf: String
          let idr: String
          let ils: String
          let inr: String
          let jpy: String
          let krw: String
          let kwd: String
          let lkr: String
          let ltc: String
          let mmk: String
          let mxn: String
          let myr: String
          let ngn: String
          let nok: String
          let nzd: String
          let php: String
          let pkr: String
          let pln: String
          let rub: String
          let sar: String
          let sek: String
          let sgd: String
          let thb: String
          let `try`: String
          let twd: String
          let uah: String
          let usd: String
          let vef: String
          let vnd: String
          let xag: String
          let xau: String
          let xdr: String
          let xlm: String
          let xrp: String
          let yfi: String
          let zar: String
          let bits: String
          let link: String
          let sats: String
        }
        
        struct MarketCap: Codable {
          let aed: String
          let ars: String
          let aud: String
          let bch: Int
          let bdt: String
          let bhd: String
          let bmd: String
          let bnb: Int
          let brl: String
          let btc: Int
          let cad: String
          let chf: String
          let clp: String
          let cny: String
          let czk: String
          let dkk: String
          let dot: String
          let eos: String
          let eth: Int
          let eur: String
          let gbp: String
          let hkd: String
          let huf: String
          let idr: String
          let ils: String
          let inr: String
          let jpy: String
          let krw: String
          let kwd: String
          let lkr: String
          let ltc: Int
          let mmk: String
          let mxn: String
          let myr: String
          let ngn: String
          let nok: String
          let nzd: String
          let php: String
          let pkr: String
          let pln: String
          let rub: String
          let sar: String
          let sek: String
          let sgd: String
          let thb: String
          let `try`: String
          let twd: String
          let uah: String
          let usd: String
          let vef: String
          let vnd: String
          let xag: String
          let xau: Int
          let xdr: String
          let xlm: String
          let xrp: String
          let yfi: Int
          let zar: String
          let bits: String
          let link: String
          let sats: String
        }
        
        struct TotalVolume: Codable {
          let aed: Double
          let ars: Double
          let aud: Double
          let bch: Double
          let bdt: Double
          let bhd: Double
          let bmd: Double
          let bnb: Double
          let brl: Double
          let btc: Double
          let cad: Double
          let chf: Double
          let clp: Double
          let cny: Double
          let czk: Double
          let dkk: Double
          let dot: Double
          let eos: Double
          let eth: Double
          let eur: Double
          let gbp: Double
          let hkd: Double
          let huf: Double
          let idr: Double
          let ils: Double
          let inr: Double
          let jpy: Double
          let krw: Double
          let kwd: Double
          let lkr: Double
          let ltc: Double
          let mmk: Double
          let mxn: Double
          let myr: Double
          let ngn: Double
          let nok: Double
          let nzd: Double
          let php: Double
          let pkr: Double
          let pln: Double
          let rub: Double
          let sar: Double
          let sek: Double
          let sgd: Double
          let thb: Double
          let `try`: Double
          let twd: Double
          let uah: Double
          let usd: Double
          let vef: Double
          let vnd: Double
          let xag: Double
          let xau: Double
          let xdr: Double
          let xlm: Double
          let xrp: Double
          let yfi: Double
          let zar: Double
          let bits: Double
          let link: Double
          let sats: Double
        }

        struct High24h: Codable {
          let aed: Double
          let ars: Double
          let aud: Double
          let bch: Double
          let bdt: Double
          let bhd: Double
          let bmd: Double
          let bnb: Double
          let brl: Double
          let btc: Double
          let cad: Double
          let chf: Double
          let clp: Double
          let cny: Double
          let czk: Double
          let dkk: Double
          let dot: Double
          let eos: Double
          let eth: Double
          let eur: Double
          let gbp: Double
          let hkd: Double
          let huf: Double
          let idr: Double
          let ils: Double
          let inr: Double
          let jpy: Double
          let krw: Double
          let kwd: Double
          let lkr: Double
          let ltc: Double
          let mmk: Double
          let mxn: Double
          let myr: Double
          let ngn: Double
          let nok: Double
          let nzd: Double
          let php: Double
          let pkr: Double
          let pln: Double
          let rub: Double
          let sar: Double
          let sek: Double
          let sgd: Double
          let thb: Double
          let `try`: Double
          let twd: Double
          let uah: Double
          let usd: Double
          let vef: Double
          let vnd: Double
          let xag: Double
          let xau: Double
          let xdr: Double
          let xlm: Double
          let xrp: Int
          let yfi: Double
          let zar: Double
          let bits: Double
          let link: Double
          let sats: Double
        }

        struct Low24h: Codable {
          let aed: Double
          let ars: Double
          let aud: Double
          let bch: Double
          let bdt: Double
          let bhd: Double
          let bmd: Double
          let bnb: Double
          let brl: Double
          let btc: Double
          let cad: Double
          let chf: Double
          let clp: Double
          let cny: Double
          let czk: Double
          let dkk: Double
          let dot: Double
          let eos: Double
          let eth: Double
          let eur: Double
          let gbp: Double
          let hkd: Double
          let huf: Double
          let idr: Double
          let ils: Double
          let inr: Double
          let jpy: Double
          let krw: Double
          let kwd: Double
          let lkr: Double
          let ltc: Double
          let mmk: Double
          let mxn: Double
          let myr: Double
          let ngn: Double
          let nok: Double
          let nzd: Double
          let php: Double
          let pkr: Double
          let pln: Double
          let rub: Double
          let sar: Double
          let sek: Int
          let sgd: Double
          let thb: Double
          let `try`: Double
          let twd: Double
          let uah: Double
          let usd: Double
          let vef: Double
          let vnd: Double
          let xag: Double
          let xau: Double
          let xdr: Double
          let xlm: Double
          let xrp: Int
          let yfi: Double
          let zar: Double
          let bits: Double
          let link: Double
          let sats: Double
        }

        struct PriceChange24hInCurrency: Codable {
          let aed: Double
          let ars: Double
          let aud: Double
          let bch: Double
          let bdt: Double
          let bhd: Double
          let bmd: Double
          let bnb: Double
          let brl: Double
          let btc: Double
          let cad: Double
          let chf: Double
          let clp: Double
          let cny: Double
          let czk: Double
          let dkk: Double
          let dot: Double
          let eos: Double
          let eth: Double
          let eur: Double
          let gbp: Double
          let hkd: Double
          let huf: Double
          let idr: Double
          let ils: Double
          let inr: Double
          let jpy: Double
          let krw: Double
          let kwd: Double
          let lkr: Double
          let ltc: Double
          let mmk: Double
          let mxn: Double
          let myr: Double
          let ngn: Double
          let nok: Double
          let nzd: Double
          let php: Double
          let pkr: Double
          let pln: Double
          let rub: Double
          let sar: Double
          let sek: Double
          let sgd: Double
          let thb: Double
          let `try`: Double
          let twd: Double
          let uah: Double
          let usd: Double
          let vef: Double
          let vnd: Double
          let xag: Double
          let xau: Double
          let xdr: Double
          let xlm: Double
          let xrp: Int
          let yfi: Double
          let zar: Double
          let bits: Double
          let link: Double
          let sats: Double
        }

        struct PriceChangePercentage1hInCurrency: Codable {
          let aed: Double
          let ars: Double
          let aud: Double
          let bch: Double
          let bdt: Double
          let bhd: Double
          let bmd: Double
          let bnb: Double
          let brl: Double
          let btc: Double
          let cad: Double
          let chf: Double
          let clp: Double
          let cny: Double
          let czk: Double
          let dkk: Double
          let dot: Double
          let eos: Double
          let eth: Double
          let eur: Double
          let gbp: Double
          let hkd: Double
          let huf: Double
          let idr: Double
          let ils: Double
          let inr: Double
          let jpy: Double
          let krw: Double
          let kwd: Double
          let lkr: Double
          let ltc: Double
          let mmk: Double
          let mxn: Double
          let myr: Double
          let ngn: Double
          let nok: Double
          let nzd: Double
          let php: Double
          let pkr: Double
          let pln: Double
          let rub: Double
          let sar: Double
          let sek: Double
          let sgd: Double
          let thb: Double
          let `try`: Double
          let twd: Double
          let uah: Double
          let usd: Double
          let vef: Double
          let vnd: Double
          let xag: Double
          let xau: Double
          let xdr: Double
          let xlm: Double
          let xrp: Int
          let yfi: Double
          let zar: Double
          let bits: Double
          let link: Double
          let sats: Double
        }

        struct PriceChangePercentage24hInCurrency: Codable {
          let aed: Double
          let ars: Double
          let aud: Double
          let bch: Double
          let bdt: Double
          let bhd: Double
          let bmd: Double
          let bnb: Double
          let brl: Double
          let btc: Double
          let cad: Double
          let chf: Double
          let clp: Double
          let cny: Double
          let czk: Double
          let dkk: Double
          let dot: Double
          let eos: Double
          let eth: Double
          let eur: Double
          let gbp: Double
          let hkd: Double
          let huf: Double
          let idr: Double
          let ils: Double
          let inr: Double
          let jpy: Double
          let krw: Double
          let kwd: Double
          let lkr: Double
          let ltc: Double
          let mmk: Double
          let mxn: Double
          let myr: Double
          let ngn: Double
          let nok: Double
          let nzd: Double
          let php: Double
          let pkr: Double
          let pln: Double
          let rub: Double
          let sar: Double
          let sek: Double
          let sgd: Double
          let thb: Double
          let `try`: Double
          let twd: Double
          let uah: Double
          let usd: Double
          let vef: Double
          let vnd: Double
          let xag: Double
          let xau: Double
          let xdr: Double
          let xlm: Double
          let xrp: Int
          let yfi: Double
          let zar: Double
          let bits: Double
          let link: Double
          let sats: Double
        }

        struct PriceChangePercentage7dInCurrency: Codable {
          let aed: Double
          let ars: Double
          let aud: Double
          let bch: Double
          let bdt: Double
          let bhd: Double
          let bmd: Double
          let bnb: Double
          let brl: Double
          let btc: Double
          let cad: Double
          let chf: Double
          let clp: Double
          let cny: Double
          let czk: Double
          let dkk: Double
          let dot: Double
          let eos: Double
          let eth: Double
          let eur: Double
          let gbp: Double
          let hkd: Double
          let huf: Double
          let idr: Double
          let ils: Double
          let inr: Double
          let jpy: Double
          let krw: Double
          let kwd: Double
          let lkr: Double
          let ltc: Double
          let mmk: Double
          let mxn: Double
          let myr: Double
          let ngn: Double
          let nok: Double
          let nzd: Double
          let php: Double
          let pkr: Double
          let pln: Double
          let rub: Double
          let sar: Double
          let sek: Double
          let sgd: Double
          let thb: Double
          let `try`: Double
          let twd: Double
          let uah: Double
          let usd: Double
          let vef: Double
          let vnd: Double
          let xag: Double
          let xau: Double
          let xdr: Double
          let xlm: Double
          let xrp: Int
          let yfi: Double
          let zar: Double
          let bits: Double
          let link: Double
          let sats: Double
        }

        struct PriceChangePercentage14dInCurrency: Codable {
          let aed: Double
          let ars: Double
          let aud: Double
          let bch: Double
          let bdt: Double
          let bhd: Double
          let bmd: Double
          let bnb: Double
          let brl: Double
          let btc: Double
          let cad: Double
          let chf: Double
          let clp: Double
          let cny: Double
          let czk: Double
          let dkk: Double
          let dot: Double
          let eos: Double
          let eth: Double
          let eur: Double
          let gbp: Double
          let hkd: Double
          let huf: Double
          let idr: Double
          let ils: Double
          let inr: Double
          let jpy: Double
          let krw: Double
          let kwd: Double
          let lkr: Double
          let ltc: Double
          let mmk: Double
          let mxn: Double
          let myr: Double
          let ngn: Double
          let nok: Double
          let nzd: Double
          let php: Double
          let pkr: Double
          let pln: Double
          let rub: Double
          let sar: Double
          let sek: Double
          let sgd: Double
          let thb: Double
          let `try`: Double
          let twd: Double
          let uah: Double
          let usd: Double
          let vef: Double
          let vnd: Double
          let xag: Double
          let xau: Double
          let xdr: Double
          let xlm: Double
          let xrp: Int
          let yfi: Double
          let zar: Double
          let bits: Double
          let link: Double
          let sats: Double
        }

        struct PriceChangePercentage30dInCurrency: Codable {
          let aed: Double
          let ars: Double
          let aud: Double
          let bch: Double
          let bdt: Double
          let bhd: Double
          let bmd: Double
          let bnb: Double
          let brl: Double
          let btc: Double
          let cad: Double
          let chf: Double
          let clp: Double
          let cny: Double
          let czk: Double
          let dkk: Double
          let dot: Double
          let eos: Double
          let eth: Double
          let eur: Double
          let gbp: Double
          let hkd: Double
          let huf: Double
          let idr: Double
          let ils: Double
          let inr: Double
          let jpy: Double
          let krw: Double
          let kwd: Double
          let lkr: Double
          let ltc: Double
          let mmk: Double
          let mxn: Double
          let myr: Double
          let ngn: Double
          let nok: Double
          let nzd: Double
          let php: Double
          let pkr: Double
          let pln: Double
          let rub: Double
          let sar: Double
          let sek: Double
          let sgd: Double
          let thb: Double
          let `try`: Double
          let twd: Double
          let uah: Double
          let usd: Double
          let vef: Double
          let vnd: Double
          let xag: Double
          let xau: Double
          let xdr: Double
          let xlm: Double
          let xrp: Int
          let yfi: Double
          let zar: Double
          let bits: Double
          let link: Double
          let sats: Double
        }

        struct PriceChangePercentage60dInCurrency: Codable {
          let aed: Double
          let ars: Double
          let aud: Double
          let bch: Double
          let bdt: Double
          let bhd: Double
          let bmd: Double
          let bnb: Double
          let brl: Double
          let btc: Double
          let cad: Double
          let chf: Double
          let clp: Double
          let cny: Double
          let czk: Double
          let dkk: Double
          let dot: Double
          let eos: Double
          let eth: Double
          let eur: Double
          let gbp: Double
          let hkd: Double
          let huf: Double
          let idr: Double
          let ils: Double
          let inr: Double
          let jpy: Double
          let krw: Double
          let kwd: Double
          let lkr: Double
          let ltc: Double
          let mmk: Double
          let mxn: Double
          let myr: Double
          let ngn: Double
          let nok: Double
          let nzd: Double
          let php: Double
          let pkr: Double
          let pln: Double
          let rub: Double
          let sar: Double
          let sek: Double
          let sgd: Double
          let thb: Double
          let `try`: Double
          let twd: Double
          let uah: Double
          let usd: Double
          let vef: Double
          let vnd: Double
          let xag: Double
          let xau: Double
          let xdr: Double
          let xlm: Double
          let xrp: Int
          let yfi: Double
          let zar: Double
          let bits: Double
          let link: Double
          let sats: Double
        }

        struct PriceChangePercentage200dInCurrency: Codable {
          let aed: Double
          let ars: Double
          let aud: Double
          let bch: Double
          let bdt: Double
          let bhd: Double
          let bmd: Double
          let bnb: Double
          let brl: Double
          let btc: Double
          let cad: Double
          let chf: Double
          let clp: Double
          let cny: Double
          let czk: Double
          let dkk: Double
          let dot: Double
          let eos: Double
          let eth: Double
          let eur: Double
          let gbp: Double
          let hkd: Double
          let huf: Double
          let idr: Double
          let ils: Double
          let inr: Double
          let jpy: Double
          let krw: Double
          let kwd: Double
          let lkr: Double
          let ltc: Double
          let mmk: Double
          let mxn: Double
          let myr: Double
          let ngn: Double
          let nok: Double
          let nzd: Double
          let php: Double
          let pkr: Double
          let pln: Double
          let rub: Double
          let sar: Double
          let sek: Double
          let sgd: Double
          let thb: Double
          let `try`: Double
          let twd: Double
          let uah: Double
          let usd: Double
          let vef: Double
          let vnd: Double
          let xag: Double
          let xau: Double
          let xdr: Double
          let xlm: Double
          let xrp: Int
          let yfi: Double
          let zar: Double
          let bits: Double
          let link: Double
          let sats: Double
        }

        struct PriceChangePercentage1yInCurrency: Codable {
          let aed: Double
          let ars: Double
          let aud: Double
          let bch: Double
          let bdt: Double
          let bhd: Double
          let bmd: Double
          let bnb: Double
          let brl: Double
          let btc: Double
          let cad: Double
          let chf: Double
          let clp: Double
          let cny: Double
          let czk: Double
          let dkk: Double
          let eos: Double
          let eth: Double
          let eur: Double
          let gbp: Double
          let hkd: Double
          let huf: Double
          let idr: Double
          let ils: Double
          let inr: Double
          let jpy: Double
          let krw: Double
          let kwd: Double
          let lkr: Double
          let ltc: Double
          let mmk: Double
          let mxn: Double
          let myr: Double
          let ngn: Double
          let nok: Double
          let nzd: Double
          let php: Double
          let pkr: Double
          let pln: Double
          let rub: Double
          let sar: Double
          let sek: Double
          let sgd: Double
          let thb: Double
          let `try`: Double
          let twd: Double
          let uah: Double
          let usd: Double
          let vef: Double
          let vnd: Double
          let xag: Double
          let xau: Double
          let xdr: Double
          let xlm: Double
          let xrp: Int
          let zar: Double
          let bits: Double
          let link: Double
          let sats: Double
        }

        struct MarketCapChange24hInCurrency: Codable {
          let aed: Double
          let ars: Double
          let aud: Double
          let bch: Double
          let bdt: Double
          let bhd: Double
          let bmd: Double
          let bnb: Double
          let brl: Double
          let btc: Double
          let cad: Double
          let chf: Double
          let clp: Double
          let cny: Double
          let czk: Double
          let dkk: Double
          let dot: Double
          let eos: Double
          let eth: Double
          let eur: Double
          let gbp: Double
          let hkd: Double
          let huf: Double
          let idr: Double
          let ils: Double
          let inr: Double
          let jpy: Double
          let krw: Double
          let kwd: Double
          let lkr: Double
          let ltc: Double
          let mmk: Double
          let mxn: Double
          let myr: Double
          let ngn: Double
          let nok: Double
          let nzd: Double
          let php: Double
          let pkr: Double
          let pln: Double
          let rub: Double
          let sar: Double
          let sek: Double
          let sgd: Double
          let thb: Double
          let `try`: Double
          let twd: Double
          let uah: Double
          let usd: Double
          let vef: Double
          let vnd: Double
          let xag: Double
          let xau: Double
          let xdr: Double
          let xlm: Double
          let xrp: Int
          let yfi: Double
          let zar: Double
          let bits: Double
          let link: Double
          let sats: Double
        }

        struct MarketCapChangePercentage24hInCurrency: Codable {
          let aed: Double
          let ars: Double
          let aud: Double
          let bch: Double
          let bdt: Double
          let bhd: Double
          let bmd: Double
          let bnb: Double
          let brl: Double
          let btc: Double
          let cad: Double
          let chf: Double
          let clp: Double
          let cny: Double
          let czk: Double
          let dkk: Double
          let dot: Double
          let eos: Double
          let eth: Double
          let eur: Double
          let gbp: Double
          let hkd: Double
          let huf: Double
          let idr: Double
          let ils: Double
          let inr: Double
          let jpy: Double
          let krw: Double
          let kwd: Double
          let lkr: Double
          let ltc: Double
          let mmk: Double
          let mxn: Double
          let myr: Double
          let ngn: Double
          let nok: Double
          let nzd: Double
          let php: Double
          let pkr: Double
          let pln: Double
          let rub: Double
          let sar: Double
          let sek: Double
          let sgd: Double
          let thb: Double
          let `try`: Double
          let twd: Double
          let uah: Double
          let usd: Double
          let vef: Double
          let vnd: Double
          let xag: Double
          let xau: Double
          let xdr: Double
          let xlm: Double
          let xrp: Int
          let yfi: Double
          let zar: Double
          let bits: Double
          let link: Double
          let sats: Double
        }



    }
}
