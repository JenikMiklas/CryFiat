//
//  CryptoAssetSelection.swift
//  CryFiat
//
//  Created by Jan Miklas on 26.05.2021.
//

import SwiftUI

struct CoinSelectionView: View {
    
    @StateObject var coinSelection: CoinSelectionVM
    @State private var search = false
    @State private var cardSize = CoinCardSize.small
    @State private var chooseCardSize = false
    @State private var addCoin = false
    //let currency: Currency
    
    init(currency: Currency) {
        //self.currency = currency
        self._coinSelection = StateObject(wrappedValue: CoinSelectionVM(currency: currency))
    }
    
    //@Binding var sheet: Bool
    // MARK: BODY
    var body: some View {
       
            ZStack {
                VStack {
                    if search {
                        SearchBarView(findToken: $coinSelection.findCoin)
                            .padding()
                            .transition(.move(edge: .top))
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
                if addCoin {
                    AddCoinView(coinSelection: coinSelection, addCoin: $addCoin)
                        .cardSelection(show: addCoin)
                }
            }
        
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Coins selection")
    }
}
// MARK: PREVIEW
struct CryptoAssetSelection_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                CoinSelectionView(currency: Currency(rawValue: "eur")!)
            }
            NavigationView {
                CoinSelectionView(currency: Currency(rawValue: "eur")!)
            }
            .previewDevice("iPod touch (7th generation)")
        }
    }
}

extension CoinSelectionView {
    // MARK: scrollList
    private var scrollList: some View {
        return ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: cardSize.rawValue), spacing: 5)]) {
                ForEach(coinSelection.marketCoins, id: \.uuid) { coin in
                    Button(action: {
                        coinSelection.addCoin = coin
                        if chooseCardSize { chooseCardSize.toggle() }
                        addCoin = true
                    }, label: {
                        CoinCardView(coin: coin, cardSize: cardSize, currency: coinSelection.currency)
                            .padding(.bottom, 5)
                    })
                        .foregroundColor(.primary)

                   /* CoinCardView(coin: coin, cardSize: cardSize)
                        .onTapGesture {
                            coinSelection.saveUserCoin(coin: coin)
                        }*/
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
            }.padding(.all, 5)
        }
    }
    // MARK: tabItems
    private var tabBarItems: some ToolbarContent {
        return Group {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    withAnimation(.easeInOut) { search.toggle() }
                    coinSelection.downloadAllCoins()
                }, label: {
                    Image(systemName: "magnifyingglass.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                })
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    if addCoin { addCoin.toggle() }
                        chooseCardSize.toggle()
                }, label: {
                    Image(systemName: "rectangle.3.offgrid")
                })
            }
        }
    }
}
