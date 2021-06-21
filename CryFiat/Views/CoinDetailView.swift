//
//  CoinDetailView.swift
//  CryFiat
//
//  Created by Jan Miklas on 21.06.2021.
//

import SwiftUI
import WebKit

struct CoinDetailView: View {
    
    @StateObject var coinDetailVM = CoinDetailVM()
    @Binding var show: Bool
    
    var body: some View {
        
        NavigationView {
            ScrollView(.vertical) {
                VStack {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Add to portfolio")
                    })
                    .background(Capsule().fill(Color.secondary))
                    Text(coinDetailVM.coinDetail?.description?.en ?? PreviewVM.detailDescription)
                }
                }
            .frame(maxWidth: .infinity)
            .ignoresSafeArea(edges: .bottom)
            .navigationTitle(coinDetailVM.coinDetail?.name ?? "XRP")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if let coin = coinDetailVM.coinDetail {
                        Image(uiImage: coinDetailVM.coinImage(coinID: coin.id))
                            .resizable()
                            .frame(width: 30, height: 30)
                    } else {
                        ProgressView()
                            .frame(width: 30, height: 30)
                    }
                    
                }
            }
        }
        .onDisappear {
            coinDetailVM.coinDetail = nil
        }
    
    }
}

struct CoinDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CoinDetailView(show: .constant(true))
    }
}
