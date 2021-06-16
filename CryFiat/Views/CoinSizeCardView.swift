//
//  CoinSizeCardView.swift
//  CryFiat
//
//  Created by Jan Miklas on 15.06.2021.
//

import SwiftUI

struct CoinSizeCardView: View {
    
    @Binding var cardSize: CoinCardSize
    @Binding var chooseCardSize: Bool
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .frame(height: 200)
                .cornerRadius(20)
            HStack {
                Button(action: {
                    cardSize = .small
                    chooseCardSize.toggle()
                }, label: {
                    RoundedRectangle(cornerRadius:10)
                        .frame(width: 90/2, height: 100/2)
                })
                Divider()
                    .frame(height: 75)
                Button(action: {
                    cardSize = .medium
                    chooseCardSize.toggle()
                }, label: {
                    RoundedRectangle(cornerRadius:10)
                        .frame(width: 135/2, height: 150/2)
                })
                Divider()
                    .frame(height: 75)
                Button(action: {
                    cardSize = .large
                    chooseCardSize.toggle()
                }, label: {
                    RoundedRectangle(cornerRadius:10)
                        .frame(width: 320/2, height: 200/2)
                })
            }.offset(y: -20)
            .foregroundColor(Color(.systemGray))
        }
    }
}
// MARK: PREVIEW
struct CoinSizeCardView_Previews: PreviewProvider {
    static var previews: some View {
        CoinSizeCardView(cardSize: .constant(CoinCardSize.small), chooseCardSize: .constant(true))
            .previewLayout(.sizeThatFits)
            .padding()
        CoinSizeCardView(cardSize: .constant(CoinCardSize.small), chooseCardSize: .constant(true))
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
