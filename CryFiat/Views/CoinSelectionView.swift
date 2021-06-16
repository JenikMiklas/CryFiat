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
    @State private var cardSize = CoinCardSize.small
    @State private var chooseCardSize = false
    //@Binding var sheet: Bool
    
    var body: some View {
        let columnsAdaptive: [GridItem] = [GridItem(.adaptive(minimum: cardSize.rawValue), spacing: 0)]
        NavigationView {
            ZStack {
                VStack {
                    if search {
                        SearchBarView(findToken: $coinSelection.findCoin)
                            .transition(.move(edge: .top))
                            .animation(.easeInOut)
                    }
                    if !coinSelection.marketCoins.isEmpty {
                        ZStack {
                            ScrollView {
                                LazyVGrid(columns: columnsAdaptive) {
                                    ForEach(coinSelection.marketCoins, id: \.uuid) { coin in
                                        CoinCardView(coin: coin, cardSize: cardSize)
                                            .onAppear {
                                                if coinSelection.findCoin.isEmpty {
                                                    if let lastCoin = coinSelection.marketCoins.last {
                                                        if lastCoin == coin {
                                                            coinSelection.downloadMoreCoins()
                                                        }
                                                    }
                                                }
                                            }
                                    }
                                }
                                .frame(width: UIScreen.main.bounds.width)
                            }
                        }
                   } else {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                   }
                    Spacer()
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: { search.toggle()
                            coinSelection.downloadAllCoins()
                        }, label: {
                            Image(systemName: "magnifyingglass.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                        })
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: { chooseCardSize.toggle() }, label: {
                            Image(systemName: "rectangle.3.offgrid")
                        })
                    }
                }
                .ignoresSafeArea(edges: .bottom)
                if chooseCardSize {
                    CoinSizeCardView(cardSize: $cardSize, chooseCardSize: $chooseCardSize)
                        .offset(y: chooseCardSize ? UIScreen.main.bounds.height/2-95:UIScreen.main.bounds.height)
                        .transition(.move(edge: .bottom))
                        .animation(.default)
                        .zIndex(99)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CryptoAssetSelection_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinSelectionView()
            CoinSelectionView()
                .previewDevice("iPhone SE (2nd generation)")
        }
            
    }
}
