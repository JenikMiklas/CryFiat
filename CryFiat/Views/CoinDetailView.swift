//
//  CoinDetailView.swift
//  CryFiat
//
//  Created by Jan Miklas on 29.06.2021.
//

import SwiftUI

struct CoinDetailView: View {
    
    let coin: CoinsTokenMarket
    let currency: Currency
    //let chartData: [Double]
    
    var body: some View {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    //if !chartData.isEmpty { chartView; Divider() }
                    chartView; Divider()
                    overview
                    Divider()
                    lastDay
                    Divider()
                    supply
                    Divider()
                    ath
                }
                .navigationTitle(coin.symbol + " / " + currency.rawValue )
                .navigationBarTitleDisplayMode(.inline)
            }
    }
}

struct CoinDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CoinDetailView(coin: PreviewVM.coin, currency: Currency.eur)
        }
    }
}

struct CoinInfo: View {
    let title: LocalizedStringKey
    let value: String
    
    var body: some View {
        VStack(alignment: .trailing) {
            Text(title)
                .bold()
                .font(.callout)
                .foregroundColor(.secondary)
                .padding(.bottom, 3)
            Text(value)
                .font(.title2)
        }.padding()
    }
}

extension CoinDetailView {
    private var chartView: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(coin.name.uppercased() )
                    .font(.title)
                Text("locChart")
                    .font(.title)
                    .foregroundColor(.secondary)
            }
            .padding()
            ChartView(coin: coin, currency: currency)
                .frame(height: 200)
        }.padding(.bottom)
    }

    private var overview: some View {
        Group {
            HStack {
                Text("locOverview")
                    .font(.title)
                    .foregroundColor(.secondary)
                Spacer()
            }.padding(.leading)
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .center, spacing: 10, pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/, content: {
                CoinInfo(title: "locRank", value: coin.marketCapRank?.coinStringValue() ?? "?")
                CoinInfo(title: "locPrice", value: coin.currentPrice.coinStringLongSymbol(currency: currency) )
                CoinInfo(title: "locMarketCap", value: coin.marketCap?.coinMarketCap() ?? "?")
                CoinInfo(title: "locVolume24h", value: coin.totalVolume?.coinMarketCap() ?? "?")
            })
        }
    }
    
    private var lastDay: some View {
        Group {
            HStack {
                Text("locLast24h")
                    .font(.title)
                    .foregroundColor(.secondary)
                Spacer()
            }.padding(.leading)
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .center, spacing: 10, pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/, content: {
                CoinInfo(title: "locPriceChange", value: coin.priceChange24h?.coinStringLongSymbol(currency: currency) ?? "?")
                CoinInfo(title: "locPricePercent", value: coin.priceChangePercentage24h?.coinStringValue() ?? "?" )
                CoinInfo(title: "locLow", value: coin.low24h?.coinStringLongSymbol(currency: currency) ?? "?")
                CoinInfo(title: "locHigh", value: coin.high24h?.coinStringLongSymbol(currency: currency) ?? "?")
                CoinInfo(title: "locMarketCapChange", value: coin.marketCapChange24h?.coinMarketCap() ?? "?")
                CoinInfo(title: "locMarketCapChangePerc", value: coin.marketCapChangePercentage24h?.coinStringValue() ?? "?")
            })
            .padding([.leading, .trailing])
        }
    }
    
    private var supply: some View {
        Group {
            HStack {
                Text("locSupply")
                    .font(.title)
                    .foregroundColor(.secondary)
                Spacer()
            }.padding(.leading)
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .center, spacing: 10, pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/, content: {
                CoinInfo(title: "locCircul", value: coin.circulatingSupply?.coinMarketCap() ?? "?")
                CoinInfo(title: "locTotal", value: coin.totalSupply?.coinMarketCap() ?? "?" )
            })
            .padding([.leading, .trailing])
        }
    }
    
    private var ath: some View {
        Group {
            HStack {
                Text("locAllTime")
                    .font(.title)
                    .foregroundColor(.secondary)
                Spacer()
            }.padding(.leading)
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .center, spacing: 10, pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/, content: {
                CoinInfo(title: "locHigh", value: coin.ath?.coinStringLongSymbol(currency: currency) ?? "?")
                CoinInfo(title: "locLow", value: coin.atl?.coinStringLongSymbol(currency: currency) ?? "?" )
                CoinInfo(title: "locHighDate", value: Date().dateFrom(string: coin.athDate ?? "").shortDateString())
                CoinInfo(title: "locLowDate", value: Date().dateFrom(string: coin.atlDate ?? "").shortDateString() )
            })
            .padding([.leading, .trailing])
        }
    }
}
