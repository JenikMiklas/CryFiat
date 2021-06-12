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

struct CryptoTokenMarket: Codable, Equatable, Hashable {
    static func == (lhs: CryptoTokenMarket, rhs: CryptoTokenMarket) -> Bool {
        lhs.id == rhs.id
    }
    
  struct Roi: Codable, Hashable {
    let times: Double?
    let currency: String?
    let percentage: Double?
  }

  let id: String
  let symbol: String
  let name: String
  let image: String
  let currentPrice: Double
  let marketCap: Int
  let marketCapRank: Int?
  let fullyDilutedValuation: Int?
  let totalVolume: Double?
  let high24h: Double?
  let low24h: Double?
  let priceChange24h: Double?
  let priceChangePercentage24h: Double?
  let marketCapChange24h: Double?
  let marketCapChangePercentage24h: Double?
  let circulatingSupply: Double
  let totalSupply: Double?
  let maxSupply: Double?
  let ath: Double
  let athChangePercentage: Double
  let athDate: String
  let atl: Double
  let atlChangePercentage: Double
  let atlDate: String
  let roi: Roi?
  let lastUpdated: String

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


struct CryptoTokenDetail: Codable {
    
 

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


  struct Image: Codable {
    let thumb: String
    let small: String
    let large: String
  }

  struct MarketData: Codable {
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

    let currentPrice: CurrentPrice
    //let priceChange24h: Double
    //let priceChangePercentage24h: Double
    //let lastUpdated: String

    private enum CodingKeys: String, CodingKey {
      case currentPrice = "current_price"
      //case priceChange24h = "price_change_24h"
      //case priceChangePercentage24h = "price_change_percentage_24h"
      //case lastUpdated = "last_updated"
    }
  }

  let id: String
  let symbol: String
  let name: String
  //let localization: Localization
  let description: Description
  let image: Image
  let marketCapRank: Int?
  //let marketData: MarketData
  let lastUpdated: String

  private enum CodingKeys: String, CodingKey {
    case id
    case symbol
    case name
   // case localization
    case description
    case image
    case marketCapRank = "market_cap_rank"
    //case marketData = "market_data"
    case lastUpdated = "last_updated"
  }
}
