//
//  CryptoAssetSelection.swift
//  CryFiat
//
//  Created by Jan Miklas on 26.05.2021.
//

import SwiftUI

struct CoinSelectionView: View {
    
    @StateObject var coinSelection = CoinSelectionVM()
    @State private var search = false
    //@State private var token = ""
    //@Binding var sheet: Bool
    
    let columnsAdaptive: [GridItem] = [GridItem(.adaptive(minimum: 90), spacing: 0)]
    
    var body: some View {
        NavigationView {
            VStack {
                if search {
                    SearchBarView(findToken: $coinSelection.findCoin)
                        .transition(.move(edge: .top))
                        .animation(.easeInOut)
                }
                if !coinSelection.marketCoins.isEmpty {
                    ScrollView {
                        LazyVGrid(columns: columnsAdaptive) {
                            ForEach(coinSelection.marketCoins, id: \.self) { coin in
                                CoinCardView(coin: coin)
                                    .onAppear {
                                        if let lastCoin = coinSelection.marketCoins.last {
                                            if lastCoin == coin {
                                                coinSelection.downloadMoreCoins()
                                            }
                                        }
                                    }
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width)
                    }
                    .animation(.easeInOut)
               } else {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
               }
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: {  }, label: {
                HStack {
                    Spacer()
                    Text("Close")
                }
            }))
            .navigationBarItems(leading: Button(action: { search.toggle() }, label: {
                Image(systemName: "magnifyingglass.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
            }))
        }
    }
}

struct CryptoAssetSelection_Previews: PreviewProvider {
    static var previews: some View {
        return CoinSelectionView()
            
    }
}
