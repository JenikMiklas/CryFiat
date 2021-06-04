//
//  CryptoDetail.swift
//  CryFiat
//
//  Created by Jan Miklas on 26.05.2021.
//

import SwiftUI

struct CryptoDetail: View {
    
    let token: Cryptocurrency
    @State private var tag = 0
    
    var body: some View {
        TabView(selection: $tag,
                content:  {
                    DetailContent(token: token).tabItem {
                        Text("\(token.symbol) vs. \(token.symbol)")
                    }.tag(0)
                    Text("Tab Content 2").tabItem {
                        Text("\(token.symbol) vs. fiat")
                    }.tag(1)
                    Text("Tab Content 3").tabItem {
                        Image(systemName: "info.circle")
                    }.tag(2)
                })
            .navigationTitle(token.name)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Image(token.id).resizable().frame(width: 35, height: 35))
    }
}

struct CryptoDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CryptoDetail(token: Cryptocurrency(id: "ripple", symbol: "xrp", name: "XRP", address: ["rUwYKnpcDr9PLfE9DzZ6r8P3qpKbqv4SyA"]))
        }
    }
}
