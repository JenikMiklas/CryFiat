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
    @State private var loadingChart = true
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    coinList
                    if !homeVM.selectedCoins.isEmpty {
                        Divider()
                        HStack {
                            Text(homeVM.selectedCoin?.name ?? "")
                                .font(.title)
                            Text("Overview")
                                .font(.title)
                                .foregroundColor(.secondary)
                            Spacer()
                        }.padding(.leading)
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .center, spacing: 10, pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/, content: {
                            CoinInfo(title: "Rank", value: homeVM.selectedCoin?.marketCapRank?.coinStringValue() ?? "?")
                            CoinInfo(title: "Price", value: homeVM.selectedCoin?.currentPrice.coinStringLongSymbol(currency: homeVM.selectedCurrency) ?? "?")
                            CoinInfo(title: "Market cap", value: homeVM.selectedCoin?.marketCap?.coinNumberString() ?? "?")
                        })
                        .padding()
                        if homeVM.chartData != nil {
                            Divider()
                            VStack(alignment: .leading) {
                                HStack(alignment: .firstTextBaseline) {
                                    Text(homeVM.selectedCoin?.symbol.uppercased() ?? "")
                                        .font(.title)
                                    Text(" / \(homeVM.selectedCurrency.rawValue.uppercased()) week chart")
                                        .font(.title)
                                        .foregroundColor(.secondary)
                                }
                                .padding()
                                ChartView(homeVM: homeVM, loadingChart: $loadingChart)
                                    .frame(height: 200)
                            }
                        }
                        
                    }
                    
                    Spacer()
                }
                .navigationTitle("CryFiat")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            NavigationLink(
                                destination:
                                    SelectCurrencyView(homeVM: homeVM, loadingChart: $loadingChart),
                                label: {
                                    Button(action: {  }, label: {
                                        if homeVM.selectedCurrency.flag != "crypto" {
                                            Text(homeVM.selectedCurrency.rawValue == "eur" ? "🇪🇺":homeVM.selectedCurrency.flag)
                                        } else {
                                            Image(homeVM.selectedCurrency.rawValue)
                                                .resizable()
                                                .frame(width: 20, height: 20)
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
                            loadingChart.toggle()
                            homeVM.getCoinData(coin: item, currency: homeVM.selectedCurrency)
                        }, label: {
                            VStack {
                                Text(item.currentPrice.coinStringSymbol(currency: homeVM.selectedCurrency))
                                    .font(.callout)
                                    .lineLimit(1)
                                    .allowsTightening(true)
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

struct CoinInfo: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .trailing) {
            Text(title)
                .bold()
                .font(.callout)
                .foregroundColor(.secondary)
                .padding(.bottom, 3)
            Text(value)
                .font(.title2)
        }.padding()
    }
}
