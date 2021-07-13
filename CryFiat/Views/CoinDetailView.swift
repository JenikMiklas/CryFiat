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
    let title: String
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
                Text("chart")
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
                Text("Overview")
                    .font(.title)
                    .foregroundColor(.secondary)
                Spacer()
            }.padding(.leading)
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .center, spacing: 10, pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/, content: {
                CoinInfo(title: "Rank", value: coin.marketCapRank?.coinStringValue() ?? "?")
                CoinInfo(title: "Price", value: coin.currentPrice.coinStringLongSymbol(currency: currency) )
                CoinInfo(title: "Market cap", value: coin.marketCap?.coinMarketCap() ?? "?")
                CoinInfo(title: "Volume 24H", value: coin.totalVolume?.coinMarketCap() ?? "?")
            })
        }
    }
    
    private var lastDay: some View {
        Group {
            HStack {
                Text("Last 24h")
                    .font(.title)
                    .foregroundColor(.secondary)
                Spacer()
            }.padding(.leading)
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .center, spacing: 10, pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/, content: {
                CoinInfo(title: "Price change", value: coin.priceChange24h?.coinStringValue() ?? "?")
                CoinInfo(title: "Price change %", value: coin.priceChangePercentage24h?.coinStringValue() ?? "?" )
                CoinInfo(title: "Low", value: coin.low24h?.coinStringValue() ?? "?")
                CoinInfo(title: "High", value: coin.high24h?.coinStringValue() ?? "?")
                CoinInfo(title: "Market cap change", value: coin.marketCapChange24h?.coinMarketCap() ?? "?")
                CoinInfo(title: "Market cap change %", value: coin.marketCapChangePercentage24h?.coinStringValue() ?? "?")
            })
            .padding([.leading, .trailing])
        }
    }
    
    private var supply: some View {
        Group {
            HStack {
                Text("Supply")
                    .font(.title)
                    .foregroundColor(.secondary)
                Spacer()
            }.padding(.leading)
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .center, spacing: 10, pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/, content: {
                CoinInfo(title: "Circulating", value: coin.circulatingSupply?.coinMarketCap() ?? "?")
                CoinInfo(title: "Total", value: coin.totalSupply?.coinMarketCap() ?? "?" )
            })
            .padding([.leading, .trailing])
        }
    }
    
    private var ath: some View {
        Group {
            HStack {
                Text("All time high")
                    .font(.title)
                    .foregroundColor(.secondary)
                Spacer()
            }.padding(.leading)
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .center, spacing: 10, pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/, content: {
                CoinInfo(title: "High", value: coin.ath?.coinStringValue() ?? "?")
                CoinInfo(title: "Low", value: coin.atl?.coinStringValue() ?? "?" )
                CoinInfo(title: "High date", value: Date().dateFrom(string: coin.athDate ?? "").shortDateString())
                CoinInfo(title: "Low date", value: Date().dateFrom(string: coin.atlDate ?? "").shortDateString() )
            })
            .padding([.leading, .trailing])
        }
    }
}
