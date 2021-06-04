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
                    List(appVM.cryptoTokens, id: \.id) { token in
                        NavigationLink(
                            destination: CryptoDetail(token: token),
                            label: {
                                Card(card: token)
                            })
                    }
                }
                Button(action: { sheet.toggle() }, label: {
                    HStack {
                        Text("Add Crypto")
                        Image(systemName: "plus.circle.fill")
                    }
                })
                .navigationTitle("CryFiat")
                .sheet(isPresented: $sheet) {
                    CryptoAssetSelection(sheet: $sheet)
            }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
                .environmentObject(AppViewModel())
    }
}

struct Card: View {
    
    let card: Cryptocurrency
    
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            
            Image(uiImage: FileManager.default.loadImage(name: card.id))
                .resizable()
                .frame(width: 100, height: 100)
                //.foregroundColor(.black)
            Text(card.symbol.uppercased())
                .font(.title2)
        }
    }
}
