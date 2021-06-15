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
            Color.white
                .frame(height: 550)
                .cornerRadius(20)
            VStack {
                Button(action: {
                    cardSize = .small
                    chooseCardSize.toggle()
                }, label: {
                    RoundedRectangle(cornerRadius:10)
                        .frame(width: 90, height: 100)
                        .foregroundColor(Color.gray.opacity(0.3))
                })
                Divider()
                Button(action: {
                    cardSize = .medium
                    chooseCardSize.toggle()
                }, label: {
                    RoundedRectangle(cornerRadius:10)
                        .frame(width: 135, height: 150)
                        .foregroundColor(Color.gray.opacity(0.3))
                })
                Divider()
                Button(action: {
                    cardSize = .large
                    chooseCardSize.toggle()
                }, label: {
                    RoundedRectangle(cornerRadius:10)
                        .frame(width: UIScreen.main.bounds.width*0.9, height: 200)
                        .foregroundColor(Color.gray.opacity(0.3))
                })
            }
        }
    }
}

struct CoinSizeCardView_Previews: PreviewProvider {
    static var previews: some View {
        CoinSizeCardView(cardSize: .constant(CoinCardSize.small), chooseCardSize: .constant(true))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
