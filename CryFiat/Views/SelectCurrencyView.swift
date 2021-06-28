//
//  SelectCurrencyView.swift
//  CryFiat
//
//  Created by Jan Miklas on 23.06.2021.
//

import SwiftUI

struct SelectCurrencyView: View {
    
    @ObservedObject var homeVM: HomeVM
    //@Binding var currency: Currency

    
    var body: some View {
        List(homeVM.selectedCurrency.currencies, id:\.rawValue) { item in
            Button(action: {
                withAnimation {
                    homeVM.selectedCurrency = item
                }
            }, label: {
                HStack {
                    Text(item.rawValue.uppercased())
                        .font(.headline)
                    Spacer()
                    if(item.flag != "crypto") {
                        Text(item.flag == "🇪🇺" ? "🇪🇺 🇧🇪 🇪🇪 🇫🇮 🇫🇷 🇮🇪 🇮🇹 🇨🇾 🇱🇹 🇱🇻 🇱🇺 🇲🇹 🇩🇪 🇳🇱 🇵🇹 🇦🇹 🇬🇷 🇸🇰 🇸🇮 🇪🇸" : item.flag)
                            .font(.largeTitle)
                    } else {
                        Image(item.rawValue)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .cornerRadius(30)
                    }
                    Spacer()
                    Text(item.symbol)
                        .font(.headline)
                    if homeVM.selectedCurrency == item {
                        Image(systemName:"checkmark.square.fill")
                            .foregroundColor(.green)
                            .font(.title2)
                    }
                }
            })
            .padding()
        }
        .navigationTitle("Select currency")
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {
            if let coin = homeVM.selectedCoin {
                homeVM.getCoinData(coin: coin, currency: homeVM.selectedCurrency)
            }
        }
    }
}

struct SelectCurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SelectCurrencyView(homeVM: HomeVM())
        }
    }
}
