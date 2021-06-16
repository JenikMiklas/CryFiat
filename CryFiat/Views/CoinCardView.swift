//
//  CoinCardView.swift
//  CryFiat
//
//  Created by Jan Miklas on 12.06.2021.
//

import SwiftUI

struct CoinCardView: View {
    
    let coin: CoinsTokenMarket
    let cardSize: CoinCardSize
    // MARK: BODY
    var body: some View {
        getSizeCard(cardSize: cardSize)
    }
}

// MARK: PREVIEW
struct CoinCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinCardView(coin: PreviewVM.coin, cardSize: .small)
                .previewLayout(.sizeThatFits)
            CoinCardView(coin: PreviewVM.coin, cardSize: .medium)
                .previewLayout(.sizeThatFits)
            CoinCardView(coin: PreviewVM.coin, cardSize: .large)
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }
        .padding()
    }
}
// MARK: EXTENSION
extension CoinCardView {
    
    @ViewBuilder
    private func getSizeCard(cardSize: CoinCardSize) -> some View {
        switch cardSize {
        case .small:
            smallCard
        case .medium:
             mediumCard
        case .large:
            largeCard
        }
    }
    
    // MARK: SMALL CARD
    private var smallCard: some View {
        rectangle
            .frame(width: cardSize.rawValue, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            .overlay(
                VStack {
                    CoinImageView(imageUrl: coin.image, coinName: coin.id)
                        .frame(width: 50, height: 50)
                    Text("\(coin.marketCapRank ?? 0)")
                        .font(.caption)
                    Text("\(coin.symbol)")
                }
            )
            .cornerRadius(10)
    }
    
    // MARK: MEDIUM CARD
    private var mediumCard: some View {
        rectangle
            .frame(width: cardSize.rawValue, height: 150)
            .overlay(
                VStack {
                    HStack(alignment: .center) {
                        VStack(alignment:.leading) {
                            Text("\(coin.marketCapRank ?? 0)")
                                .font(.headline)
                            Text("\(coin.symbol)")
                                .font(.title2)
                        }
                        Spacer()
                        CoinImageView(imageUrl: coin.image, coinName: coin.id)
                            .frame(width: 50, height: 50)
                    }
                    .padding(.top, 5)
                    .padding(.trailing, 5)
                    .padding(.leading, 5)
                    Text(coin.currentPrice.coinStringValue())
                        .font(.title2)
                        .padding(3)
                    HStack {
                        Text("24H: ")
                        Text(coin.priceChangePercentage24h?.coinPercentString() ?? "?")
                            .foregroundColor((coin.priceChangePercentage24h ?? 0 > 0) ? .green:.red)
                    } .font(.subheadline)
                }
            )
    }
    
    // MARK: LARGE CARD
    private var largeCard: some View {
        rectangle
            .frame(width: cardSize.rawValue, height: 200)
            .overlay(
                VStack {
                    HStack(alignment: .center) {
                        VStack(alignment:.leading) {
                            Text("\(coin.marketCapRank ?? 0)")
                                .font(.headline)
                            Text("\(coin.symbol)")
                                .font(.title2)
                        }
                        Spacer()
                        VStack {
                            Text(coin.currentPrice.coinStringValue())
                                .font(.title2)
                            HStack {
                                VStack {
                                    Text("24H: \(coin.high24h?.coinStringSymbol() ?? "?")")
                                    Text("24L: \(coin.low24h?.coinStringSymbol() ?? "?")")
                                }
                                VStack {
                                    Text(coin.priceChangePercentage24h?.coinPercentString() ?? "?")
                                        .foregroundColor((coin.priceChangePercentage24h ?? 0 > 0) ? Color(.systemGreen):Color(.systemRed))
                                    Text(coin.priceChange24h?.coinStringSymbol() ?? "?")
                                        .foregroundColor((coin.priceChangePercentage24h ?? 0 > 0) ? Color(.systemGreen):Color(.systemRed))
                                       
                                }
                            }.font(.subheadline).padding(.top, 5)
                        }
                        Spacer()
                        CoinImageView(imageUrl: coin.image, coinName: coin.id)
                            .frame(width: 50, height: 50)
                    }
                        .padding(.top, 10.0)
                    HStack(alignment: .center) {
                        VStack(alignment:.leading) {
                            Text("ath: \(coin.ath?.coinStringSymbol() ?? "?")")
                            Text("atl: \(coin.atl?.coinStringSymbol() ?? "?")")
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("circulating / total supply")
                            Text(coin.circulatingSupply?.coinNumberString() ?? "?")
                            Text(coin.totalSupply?.coinNumberString() ?? "?")
                        }.font(.subheadline)
                        .padding(.top, 10)
                    }
                    Spacer()
                }
                .padding([.leading, .trailing], 10.0)
                //.foregroundColor(Color.white)
            )
    }
    
    // MARK: RECTANGLE
    private var rectangle: some View {
        RoundedRectangle(cornerRadius: 10)
             .fill(
                 LinearGradient(gradient: Gradient(colors: [Color(.systemGray), Color(.systemGray5)]), startPoint: .topLeading, endPoint: .bottomTrailing)
             )
            .shadow(radius: 2)
    }
}

