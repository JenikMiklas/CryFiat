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
    @State private var width: CGFloat = UIScreen.main.bounds.width
    //@Binding var sheet: Bool
    // MARK: BODY
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    if search {
                        SearchBarView(findToken: $coinSelection.findCoin)
                            .transition(.move(edge: .top))
                            .animation(.easeInOut)
                    }
                    if !coinSelection.marketCoins.isEmpty {
                        scrollList
                   } else {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                   }
                    Spacer()
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    tabBarItems
                }
                .ignoresSafeArea(edges: .bottom)
                if chooseCardSize {
                    CoinSizeCardView(cardSize: $cardSize, chooseCardSize: $chooseCardSize)
                        .cardSelection(show: chooseCardSize)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
// MARK: PREVIEW
struct CryptoAssetSelection_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinSelectionView()
            CoinSelectionView()
                .previewDevice("iPhone SE (2nd generation)")
        }
            
    }
}

extension CoinSelectionView {
    // MARK: scrollList
    private var scrollList: some View {
        return ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: cardSize.rawValue), spacing: 0)]) {
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
        }
    }
    // MARK: tabItems
    private var tabBarItems: some ToolbarContent {
        return Group {
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
    }
}
