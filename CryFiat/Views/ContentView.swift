//
//  ContentView.swift
//  CryFiat
//
//  Created by Jan Miklas on 21.05.2021.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var appVM: AppViewModel
    @State private var sheet = false
    
    let columns: [GridItem] = Array(repeating: .init(.fixed(10)), count: 1)
    
    var body: some View {
       
        NavigationView {
            VStack {
                if appVM.cryptoTokens.isEmpty {
                        Text("Add your crypto...")
                            .font(.title)
                            .foregroundColor(.primary)
                            .opacity(0.5)
                            .padding()
                    
                } else {
                    ScrollView {
                            LazyVGrid(columns: columns) {
                                ForEach(appVM.cryptoTokensMarket, id: \.id) { token in
                                    Card(card: token)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("CryFiat")
            .navigationBarItems(trailing: Button(action: {sheet.toggle()}, label: {
                Text("Add Crypto")
                Image(systemName: "plus.circle.fill")
            }))
                .sheet(isPresented: $sheet) {
                    CryptoAssetSelection(sheet: $sheet)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = AppViewModel()
        vm.cryptoTokensMarket = [CryptoTokenMarket(id: "ripple", symbol: "xrp", name: "XRP", currentPrice: 0.707961, marketCapRank: 7, priceChange24h: -0.08380801, priceChangePercentage24h: -10.58491, lastUpdated: "2021-06-08T11:23:41.422Z")]
        return ContentView()
            .environmentObject(AppViewModel())
    }
}

struct Card: View {
    
    let card: CryptoTokenMarket
    
    var body: some View {
        /*HStack(alignment: .center, spacing: 15) {
            
            Image(uiImage: FileManager.default.loadImage(name: card.id))
                .resizable()
                .frame(width: 100, height: 100)
                //.foregroundColor(.black)
            Text(card.symbol.uppercased())
                .font(.title2)
        }*/
       
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.secondary.opacity(0.5))
                VStack {
                    HStack {
                        Spacer()
                        Image(uiImage: FileManager.default.loadImage(name: card.id))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .cornerRadius(50)
                            .padding([.top, .trailing])
                    }
                    .foregroundColor(.primary)
                    VStack {
                        Text("\(card.currentPrice) €")
                            .font(.largeTitle)
                            .bold()
                        HStack {
                            Text("last 24h:")
                                .font(.caption2)
                          
                                    Text("\(card.priceChangePercentage24h) %")
                                        .font(.caption)
                                    Text("\(card.priceChange24h) €")
                                        .font(.caption)
                            
                                
                         
                        }
                    }
                    HStack(alignment: .firstTextBaseline, spacing: 0) {
                      
                        Text("\(card.marketCapRank)")
                            .font(.title2)
                            .bold()
                            .padding(.leading)
                        Text("#")
                            .font(.caption)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        Text(card.symbol)
                            .font(.title2)
                            .bold()
                            .foregroundColor(.primary)
                            .padding()
                    }
                    
                    HStack {
                        Text("updated:")
                        Text("\(card.lastUpdated)")
                    }
                    .font(.caption2)
                    .padding(.bottom, 5)
            }
        }
            .padding()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width/1.6)
            
    }
}
