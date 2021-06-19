//
//  HomeView.swift
//  CryFiat
//
//  Created by Jan Miklas on 19.06.2021.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var homeVM = HomeVM()
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(homeVM.userCoins, id:\.id) { item in
                            CoinImageView(imageUrl: "", coinName: item.coinID!)
                                .contextMenu(menuItems: {
                                    Button(action: {
                                        homeVM.remove(coin: item)
                                    }, label: {
                                        Label("Remove", systemImage: "trash")
                                    })
                                })
                        }
                    }
                }
                .padding(.top)
                .frame(height: 75)
                ScrollView(.vertical) {
                    Text("detail")
                }
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
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            
    }
}
