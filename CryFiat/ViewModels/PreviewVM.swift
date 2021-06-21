//
//  PreviewVM.swift
//  CryFiat
//
//  Created by Jan Miklas on 12.06.2021.
//

import Foundation

//MARK: PREVIEW STUFF

class PreviewVM: ObservableObject {
    
    static let coin = CoinsTokenMarket(id: "ripple", symbol: "xrp", name: "XRP", image: "https://assets.coingecko.com/coins/images/44/large/xrp-symbol-white-128.png?1605778731", currentPrice: 0.688555, marketCap: 31869995476, marketCapRank: 7, fullyDilutedValuation: nil, totalVolume: 2533819362, high24h: 0.712954, low24h: 0.668016, priceChange24h: -0.02268778, priceChangePercentage24h: -3.18988, marketCapChange24h: -991331492.0419235, marketCapChangePercentage24h: -3.01671, circulatingSupply: 46189574356, totalSupply: 100000000000, maxSupply: nil, ath: 2.82, athChangePercentage: -75.55872, athDate: "2018-01-07T00:00:00.000Z", atl: 0.00194619, atlChangePercentage: 35353.02988, atlDate: "2013-08-16T00:00:00.000Z", roi: nil, lastUpdated: "2021-06-12T15:27:29.069Z")
    
    static let detailDescription = "Ripple is the catchall name for the cryptocurrency platform, the transactional protocol for which is actually XRP, in the same fashion as <a href=\"https://www.coingecko.com/en/coins/ethereum\">Ethereum</a> is the name for the platform that facilitates trades in Ether. Like other cryptocurrencies, Ripple is built atop the idea of a distributed ledger network which requires various parties to participate in validating transactions, rather than any singular centralized authority. That facilitates transactions all over the world, and transfer fees are far cheaper than the likes of bitcoin. Unlike other cryptocurrencies, XRP transfers are effectively immediate, requiring no typical confirmation time.\r\n\r\nRipple was originally founded by a single company, <a href=\"https://www.crunchbase.com/organization/ripple-labs\">Ripple Labs</a>, and continues to be backed by it, rather than the larger network of developers that continue <a href=\"https://www.coingecko.com/en/coins/bitcoin\">bitcoin’s</a> development. It also doesn’t have a fluctuating amount of its currency in existence. Where bitcoin has a continually growing pool with an eventual maximum, and Ethereum theoretically has no limit, Ripple was created with all of its 100 billion XRP tokens right out of the gate. That number is maintained with no mining and most of the tokens are owned and held by Ripple Labs itself — around 60 billion at the latest count.\r\n\r\nEven at the recently reduced value of around half a dollar per XRP, that means Ripple Labs is currently sitting on around $20 billion worth of the cryptocurrency (note: Ripple’s price crashed hard recently, and may be worth far less than $60 billion by time you read this). It holds 55 billion XRP in an escrow account, which allows it to sell up to a billion per month if it so chooses in order to fund new projects and acquisitions. Selling such an amount would likely have a drastic effect on the cryptocurrency’s value, and isn’t something Ripple Labs plans to do anytime soon.\r\n\r\nIn actuality, Ripple Labs is looking to leverage the technology behind XRP to allow for faster banking transactions around the world. While Bitcoin and other cryptocurrencies are built on the idea of separating financial transactions from the financial organizations of traditional currencies, Ripple is almost the opposite in every sense.\r\n\r\nXRP by Ripple price can be found on this page alongside the market capitalization and additional stats.\r\n\r\n"
    
    static let coinImage = "https://assets.coingecko.com/coins/images/44/small/xrp-symbol-white-128.png?1605778731"
    
    }
