//
//  CoinCardView.swift
//  CryFiat
//
//  Created by Jan Miklas on 12.06.2021.
//

import SwiftUI

struct CoinCardView: View {
    
    let coin: CryptoTokenMarket
    
    var body: some View {
        smallCard
    }
}

struct CoinCardView_Previews: PreviewProvider {
    static var previews: some View {
        CoinCardView(coin: PreviewVM.coin)
            .previewLayout(.sizeThatFits)
    }
}

extension CoinCardView {
    private var smallCard: some View {
        Color.gray
            .opacity(0.3)
            .frame(width: 90, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
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
}
