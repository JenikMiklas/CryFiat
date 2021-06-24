//
//  SelectCurrencyView.swift
//  CryFiat
//
//  Created by Jan Miklas on 23.06.2021.
//

import SwiftUI

struct SelectCurrencyView: View {
    
    @ObservedObject var homeVM: HomeVM
    @Binding var currency: Currency
    
    var body: some View {
        List(currency.curencies, id:\.rawValue) { item in
            Button(action: {
                withAnimation {
                    currency = item
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
                    if currency == item {
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
    }
}

struct SelectCurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SelectCurrencyView(homeVM: HomeVM(), currency: .constant(Currency(rawValue: "eur")!))
        }
    }
}
