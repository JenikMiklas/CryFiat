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
    
    let columns: [GridItem] = Array(repeating: .init(.fixed(10)), count: 1)
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("search token", text: $cfVM.tokenFind)
                        .textFieldStyle(PlainTextFieldStyle())
                    Button(action: {
                       cfVM.findCryptoToken(token: token)
                    }, label: {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .font(.title)
                    })
                }
                .padding()
                if !cfVM.tokenList.isEmpty {
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(cfVM.tokenList.indices, id: \.self) { index in
                                if cfVM.tokenList.count == cfVM.tokenImages.count {
                                    TokenCard(cfVM: cfVM, tokenDetail: cfVM.tokenDetails[index], token: cfVM.tokenList[index], image: cfVM.tokenImages[index])
                                } else if cfVM.tokenList.count == cfVM.tokenImages.count {
                                    TokenCard(cfVM: cfVM, tokenDetail: cfVM.tokenDetails[index], token: cfVM.tokenList[index], image: UIImage(systemName: "questionmark")!)
                                }
                            }
                        }
                    }
                }
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
    let tokenDetail: CryptoTokenDetail
    let token: Cryptocurrency
    let image: UIImage
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.secondary.opacity(0.5))
            VStack {
                HStack {
                    Text(token.name)
                        .font(.title)
                        .padding(.leading)
                    Button(action: {
                        //cfVM.getCryptoDetail(cryptoID: token.id)
                        if !appVM.cryptoTokens.contains(token) {
                                        appVM.cryptoTokens.append(token)
                                        cfVM.saveImageToken(image: image, name: token.id)
                        }
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                    })
                    Spacer()
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .cornerRadius(50)
                        .padding([.top, .trailing])
                }
                .foregroundColor(.primary)
                VStack {
                    Text("\(tokenDetail.description.en)")
                        .font(.caption2)
                        .padding([.leading, .trailing])
                }
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                  
                    Text("\(tokenDetail.marketCapRank ?? 0)")
                        .font(.title2)
                        .bold()
                        .padding(.leading)
                    Text("#")
                        .font(.caption)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    Text(tokenDetail.symbol)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.primary)
                        .padding()
                }
                
                HStack {
                    Text("updated:")
                    Text("\(tokenDetail.lastUpdated)")
                }
                .font(.caption2)
                .padding(.bottom, 5)
        }
    }
        .padding()
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width/1.6)
    }
}
