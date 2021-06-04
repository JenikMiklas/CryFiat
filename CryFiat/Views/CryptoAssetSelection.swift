//
//  CryptoAssetSelection.swift
//  CryFiat
//
//  Created by Jan Miklas on 26.05.2021.
//

import SwiftUI

struct CryptoAssetSelection: View {
    
    @EnvironmentObject var appVM: AppViewModel
    @StateObject var cfVM = DataStoreModel()
    @State private var token = ""
    @Binding var sheet: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                //if search {
                    HStack {
                        TextField("search token", text: $token)
                            .textFieldStyle(PlainTextFieldStyle())
                            .onChange(of: token) {
                                cfVM.findCryptoToken(token: $0)
                            }
                        Button(action: {
                           cfVM.findCryptoToken(token: token)
                        }, label: {
                            Image(systemName: "magnifyingglass.circle.fill")
                                .font(.title)
                        })
                    }
                    .padding()
                //}
                if !cfVM.tokenList.isEmpty {
                    List(cfVM.tokenList.indices, id: \.self) { index in
                        if cfVM.tokenList.count == cfVM.tokenImages.count {
                            TokenCard(cfVM: cfVM, token: cfVM.tokenList[index], image: cfVM.tokenImages[index])
                        } else {
                            TokenCard(cfVM: cfVM, token: cfVM.tokenList[index], image: UIImage(systemName: "questionmark")!)
                        }
                    }
                    .listStyle(PlainListStyle())
                }/* else {
                    List(cfVM.tokens, id: \.id) { token in
                        TokenCard(token: token)
                    }
                    .listStyle(PlainListStyle())
                }*/
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: { sheet.toggle() }, label: {
                HStack {
                    Spacer()
                    Text("Close")
                }
            }))
        }
    }
}

struct CryptoAssetSelection_Previews: PreviewProvider {
    static var previews: some View {
        let cfVM = DataStoreModel()
        cfVM.tokenList = [Cryptocurrency(id: "bitcoin", symbol: "btc", name: "Bitcoin"), Cryptocurrency(id: "ethereum", symbol: "eth", name: "Ethereum"),
            Cryptocurrency(id: "tether", symbol: "usdt", name:"Tether"),
            Cryptocurrency(id: "binancecoin", symbol: "bnb", name:"Binance Coin"),
            Cryptocurrency(id: "cardano", symbol: "ada", name:"Cardano"),
            Cryptocurrency(id: "ripple", symbol: "xrp", name: "XRP"),
            Cryptocurrency(id: "dogecoin", symbol: "doge", name:"Dogecoin"),
            Cryptocurrency(id: "polkadot", symbol: "dot", name:"Polkadot"),
            Cryptocurrency(id: "usd-coin", symbol: "usdc", name:"USD Coin"),
            Cryptocurrency(id: "internet-computer", symbol: "icp", name: "Internet Computer")]
        return CryptoAssetSelection(cfVM: cfVM, sheet: .constant(false))
            .environmentObject(AppViewModel())
    }
}

struct TokenCard: View {
    
    @EnvironmentObject var appVM: AppViewModel
    @ObservedObject var cfVM: DataStoreModel
    let token: Cryptocurrency
    let image: UIImage
    
    var body: some View {
        Button(action: {
            //cfVM.getCryptoDetail(cryptoID: token.id)
            if !appVM.cryptoTokens.contains(token) {
                appVM.cryptoTokens.append(token)
                cfVM.saveImageToken(image: image, name: token.id)
            }
        }, label: {
            HStack {
                Image(uiImage:image)
                    .resizable()
                    .frame(width: 75, height: 75)
                    .padding(.trailing, 10)
                Spacer()
                VStack(alignment: .center, spacing: 11) {
                    Text(token.name)
                        .font(.title)
                    HStack(alignment: .lastTextBaseline) {
                        Text("id:")
                            .font(.caption)
                        Text(token.id)
                        Text("symbol:")
                            .font(.caption)
                        Text(token.symbol)
                    }.font(.title3)
                }
                Spacer()
            }
        })
    }
}
