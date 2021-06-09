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
                                ForEach(appVM.cryptoTokens, id: \.id) { token in
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
        return ContentView()
            .environmentObject(AppViewModel())
    }
}

struct Card: View {
    
    let card: Cryptocurrency
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
                    Text(card.name)
                        .font(.title)
                        .padding(.leading)
                    Spacer()
                    Image(uiImage: FileManager.default.loadImage(name: card.id))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .cornerRadius(50)
                        .padding([.top, .trailing])
                }
                .foregroundColor(.primary)
               /* VStack {
                    Text("\(card.description.en)")
                        .font(.caption2)
                        .padding([.leading, .trailing])
                }*/
                /*HStack(alignment: .firstTextBaseline, spacing: 0) {
                  
                    Text("\(card.marketCapRank ?? 0)")
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
                }*/
                
               /* HStack {
                    Text("updated:")
                    Text("\(card.lastUpdated)")
                }
                .font(.caption2)
                .padding(.bottom, 5)*/
        }
    }
        .padding()
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width/1.6)
            
    }
}
