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
    // MARK: CARDS
    private var smallCard: some View {
        RoundedRectangle(cornerRadius: 10)
             .fill(
                 LinearGradient(gradient: Gradient(colors: [Color(.systemGray), Color(.systemGray5)]), startPoint: .topLeading, endPoint: .bottomTrailing)
             )
            .frame(width: cardSize.rawValue, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            .shadow(radius: 2)
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
    
    private var mediumCard: some View {
        RoundedRectangle(cornerRadius: 10)
             .fill(
                 LinearGradient(gradient: Gradient(colors: [Color(.systemGray), Color(.systemGray5)]), startPoint: .topLeading, endPoint: .bottomTrailing)
             )
            .frame(width: cardSize.rawValue, height: 150)
            .shadow(radius: 2)
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
                    Text(coin.priceChangePercentage24h?.coinPercentString() ?? "?")
                        .font(.title3)
                        .foregroundColor((coin.priceChangePercentage24h ?? 0 > 0) ? .green:.red)
                }
            )
    }
    
    private var largeCard: some View {
       RoundedRectangle(cornerRadius: 10)
            .fill(
                LinearGradient(gradient: Gradient(colors: [Color(.systemGray), Color(.systemGray5)]), startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .frame(width: cardSize.rawValue, height: 200)
            .shadow(radius: 2)
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
                        Text(coin.currentPrice.coinStringValue())
                            .font(.title2)
                        Spacer()
                        CoinImageView(imageUrl: coin.image, coinName: coin.id)
                            .frame(width: 50, height: 50)
                    }
                    .padding([.top, .leading, .trailing], 10.0)
                    Text(coin.priceChangePercentage24h?.coinPercentString() ?? "?")
                        .font(.title3)
                        .foregroundColor((coin.priceChangePercentage24h ?? 0 > 0) ? Color(.systemGreen):Color(.systemRed))
                    Spacer()
                }
                //.foregroundColor(Color.white)
            )
    }
}
