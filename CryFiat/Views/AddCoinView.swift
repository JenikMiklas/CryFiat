//
//  AddCoinView.swift
//  CryFiat
//
//  Created by Jan Miklas on 21.06.2021.
//

import SwiftUI

struct AddCoinView: View {
    
    @ObservedObject var coinSelection: CoinSelectionVM
    @Binding var addCoin: Bool
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .frame(height: 200)
                .cornerRadius(20)
                VStack {
                    HStack {
                        Image(uiImage: coinSelection.getImageCoin(coinID: coinSelection.addCoin!.id))
                         .resizable()
                         .frame(width: 50, height: 50)
                            .cornerRadius(50)
                     Button(action: {
                        coinSelection.saveUserCoin(coin: coinSelection.addCoin!)
                        addCoin.toggle()
                     }, label: {
                        Text("Add \(coinSelection.addCoin!.name)")
                             .padding()
                             .background(Capsule().fill(Color.blue))
                             .foregroundColor(.white)
                     })
                    }
                Button(action: {
                    addCoin.toggle()
                }, label: {
                    Text("cancel")
                        .padding()
                        .foregroundColor(.primary)
                })
            }.offset(y: -20)
            .foregroundColor(Color(.systemGray))
        }
    }
}

struct AddCoinView_Previews: PreviewProvider {
    static var previews: some View {
        AddCoinView(coinSelection: CoinSelectionVM(), addCoin: .constant(false))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
