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
    
    var body: some View {
        NavigationView {
            VStack {
                coinList
                Text(homeVM.selectedCoin?.name ?? "")
                
                Spacer()
            }
            .navigationTitle("CryFiat")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(
                        destination: CoinSelectionView(),
                        label: {
                            Image(systemName: "plus.circle.fill")
                        })
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    if !homeVM.userCoins.isEmpty {
                    Button(action: { updateCoinList.toggle() }, label: {
                        if !updateCoinList {
                            Image(systemName: "trash.circle.fill")
                        } else {
                            Text("Close editing")
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
                ForEach(homeVM.userCoins, id:\.id) { item in
                    ZStack(alignment: .center) {
                        Button(action: {
                            homeVM.getSelectedCoin(coinID: item.coinID!)
                        }, label: {
                            VStack {
                                CoinImageView(imageUrl: "", coinName: item.coinID!)
                                    .opacity(updateCoinList ? 0.4 : 1)
                                Text(item.symbol?.uppercased() ?? "")
                                    .font(.headline)
                                    .lineLimit(1)
                                    .allowsTightening(false)
                                    .foregroundColor(.primary)
                                Text(item.name ?? "")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .lineLimit(1)
                                    .allowsTightening(false)
                            }
                            .opacity(updateCoinList ? 0.8 : 1)
                            .frame(width: 75)
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
        .frame(height: 100)
        .padding(.top)
    }
}
