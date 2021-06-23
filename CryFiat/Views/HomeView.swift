//
//  HomeView.swift
//  CryFiat
//
//  Created by Jan Miklas on 19.06.2021.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var homeVM = HomeVM()
    @State private var updateCoinList = false
    @State private var selectCurrency = false
    
    var body: some View {
        NavigationView {
            VStack {
                coinList
                if !homeVM.selectedCoins.isEmpty {
                    Text(homeVM.selectedCoin?.name ?? homeVM.selectedCoins.first?.name ?? "")
                } else {
                    ProgressView()
                }
                
                Spacer()
            }
            .navigationTitle("CryFiat")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        NavigationLink(
                            destination:
                                SelectCurrencyView(homeVM: homeVM, currency: $homeVM.selectedCurrency),
                            label: {
                                Button(action: { selectCurrency.toggle() }, label: {
                                    if homeVM.selectedCurrency.flag != "crypto" {
                                        Text(homeVM.selectedCurrency.rawValue == "eur" ? "🇪🇺":homeVM.selectedCurrency.flag)
                                    } else {
                                        Image(homeVM.selectedCurrency.rawValue)
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                    }
                                })
                            })
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        NavigationLink(
                            destination: CoinSelectionView(currency: homeVM.storedCurrency),
                            label: {
                                Image(systemName: "plus.circle.fill")
                        })
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    if !homeVM.userCoins.isEmpty {
                    Button(action: {
                        withAnimation {
                            updateCoinList.toggle()
                        }
                    }, label: {
                        if !updateCoinList {
                            Image(systemName: "trash.circle.fill")
                        } else {
                            Image(systemName: "xmark.circle")
                        }
                    })
                }
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            
            
            
    }
}

extension HomeView {
    // MARK: COIN LIST
    private var coinList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(homeVM.selectedCoins, id:\.uuid) { item in
                    ZStack(alignment: .center) {
                        Button(action: {
                            homeVM.selectedCoin = item
                        }, label: {
                            VStack {
                                Text(item.currentPrice.coinStringSymbol(currency: homeVM.selectedCurrency))
                                    .font(.callout)
                                    .lineLimit(1)
                                    .allowsTightening(false)
                                    .foregroundColor(item.priceChangePercentage24h ?? 0 > 0 ? .green:.red)
                                CoinImageView(imageUrl: "", coinName: item.id)
                                    .opacity(updateCoinList ? 0.4 : 1)
                                Text(item.symbol.uppercased())
                                    .font(.headline)
                                    .lineLimit(1)
                                    .allowsTightening(false)
                                    .foregroundColor(.primary)
                                Text(item.name)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .lineLimit(1)
                                    .allowsTightening(false)
                            }
                            .opacity(updateCoinList ? 0.8 : 1)
                            .frame(width: 80)
                            .padding(.trailing, 10)
                        })
                        .disabled(updateCoinList)
                        if updateCoinList {
                            Button(action: {
                                homeVM.remove(coin: item)
                                if homeVM.userCoins.isEmpty {
                                    updateCoinList.toggle()
                                }
                            }, label: {
                               Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.red)
                            })
                            .offset(x: 25,y: -30)
                        }
                    }
                }
            }
        }
        .frame(height: 130)
        .padding(.top)
    }
}
