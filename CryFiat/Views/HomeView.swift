//
//  HomeView.swift
//  CryFiat
//
//  Created by Jan Miklas on 19.06.2021.
//

import CoreImage.CIFilterBuiltins
import SwiftUI

struct HomeView: View {
    
    @StateObject var homeVM = HomeVM()
    @State private var updateCoinList = false
    @State private var amountEditing = false
    @State private var priceEditing = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    coinList
                    if let coin = homeVM.selectedCoin {
                        HStack {
                            NavigationLink(
                                destination: CoinDetailView(coin: coin, currency: homeVM.selectedCurrency),
                                label: {
                                    VStack(alignment: .leading) {
                                        Text(coin.name)
                                            .font(.title)
                                        Text("\(coin.symbol.uppercased()) detail")
                                            .padding()
                                            .font(.headline)
                                            .background(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(lineWidth: 2)
                                                    .foregroundColor(.secondary)
                                            )
                                    }.padding().foregroundColor(.primary)
                                })
                            Spacer()
                        }
                        coinAddress
                        QRCodeView(address: $homeVM.qrAddress)
                            .frame(minWidth: 100, idealWidth: 300, maxWidth: 600, minHeight: 100, idealHeight: 300, maxHeight: 600, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                    }
                    Spacer()
                }
                .navigationTitle("CryFiat")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            NavigationLink(
                                destination:
                                    SelectCurrencyView(homeVM: homeVM),
                                label: {
                                    Button(action: {  }, label: {
                                        if homeVM.selectedCurrency.flag != "crypto" {
                                            Text(homeVM.selectedCurrency.rawValue == "eur" ? "🇪🇺":homeVM.selectedCurrency.flag)
                                        } else {
                                            Image(homeVM.selectedCurrency.rawValue)
                                                .resizable()
                                                .frame(width: 20, height: 20)
                                        }
                                    })
                                })
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            NavigationLink(
                                destination: CoinSelectionView(currency: homeVM.storedCurrency),
                                label: {
                                    Image(systemName: "plus.circle.fill")
                            })
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        if !homeVM.userCoins.isEmpty {
                        Button(action: {
                            withAnimation {
                                updateCoinList.toggle()
                            }
                        }, label: {
                            if !updateCoinList {
                                Image(systemName: "trash.circle.fill")
                            } else {
                                Image(systemName: "xmark.circle")
                            }
                        })
                    }
                    }
            }
                .onTapGesture {
                    UIApplication.shared.hideKeyboard()
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension HomeView {
    // MARK: COIN LIST
    private var coinList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(homeVM.selectedCoins, id:\.uuid) { item in
                    ZStack(alignment: .center) {
                        Button(action: {
                            homeVM.getCoinData(coin: item, currency: homeVM.selectedCurrency)
                        }, label: {
                            VStack {
                                Text(item.currentPrice.coinStringSymbol(currency: homeVM.selectedCurrency))
                                    .font(.callout)
                                    .lineLimit(1)
                                    .allowsTightening(true)
                                    .foregroundColor(item.priceChangePercentage24h ?? 0 > 0 ? .green:.red)
                                CoinImageView(imageUrl: "", coinName: item.id)
                                    .opacity(updateCoinList ? 0.4 : 1)
                                Text(item.symbol.uppercased())
                                    .font(.headline)
                                    .lineLimit(1)
                                    .allowsTightening(false)
                                    .foregroundColor(.primary)
                                Text(item.name)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .lineLimit(1)
                                    .allowsTightening(false)
                            }
                            .opacity(updateCoinList ? 0.8 : 1)
                            .frame(width: 80)
                            .padding(.trailing, 10)
                        })
                        .disabled(updateCoinList)
                        if updateCoinList {
                            Button(action: {
                                homeVM.remove(coin: item)
                                if homeVM.userCoins.isEmpty {
                                    updateCoinList.toggle()
                                }
                            }, label: {
                               Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.red)
                            })
                            .offset(x: 25,y: -30)
                        }
                    }
                }
            }
        }
        .frame(height: 130)
        .padding(.top)
    }
    // MARK: Coin Address
    private var coinAddress: some View {
        VStack(alignment: .leading) {
            Text("address")
                .foregroundColor(.secondary)
            TextField("", text: $homeVM.address)
                .padding()
                .background(Color.secondary.opacity(0.2))
                .cornerRadius(10)
            HStack {
                VStack(alignment: .leading) {
                    Text(homeVM.selectedCoin?.symbol ?? "")
                        .foregroundColor(.secondary)
                    TextField("", text: $homeVM.amount) { changed in
                        amountEditing = changed
                    }
                    .keyboardType(.numbersAndPunctuation)
                    .padding()
                    .background(Color.secondary.opacity(0.2))
                    .cornerRadius(10)
                    .onChange(of: homeVM.amount, perform: { value in
                        if amountEditing {
                            homeVM.updatePrice(amount: value)
                        }
                    })
                }
                VStack(alignment: .leading) {
                    Group {
                    Text(homeVM.selectedCurrency.rawValue)
                        .foregroundColor(.secondary)
                    TextField("", text: $homeVM.price) { changed in
                            priceEditing = changed
                        }
                    .keyboardType(.numbersAndPunctuation)
                        .padding()
                        .background(Color.secondary.opacity(0.2))
                        .cornerRadius(10)
                        .onChange(of: homeVM.price, perform: { value in
                            if priceEditing {
                                homeVM.updateAmount(price: value)
                            }
                    })
                    }
                }
            }
        }.padding([.leading, .trailing])
    }
}



// MARK: QRCODE
struct QRCodeView: View {
    
    @Binding var address: String
    
    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()
    var body: some View {
        Image(uiImage: generateQRCode(from: "\(address)"))
            .interpolation(.none)
            .resizable()
            .scaledToFit()
           /* VStack {
                TextField("jméno", text: $name)
                    .textContentType(.URL)
                    .font(.title)
                    .padding(.horizontal)
                /*TextField("váš@email.cz", text: $email)
                    .font(.title)
                    .padding([.horizontal, .bottom])*/
                Image(uiImage: generateQRCode(from: "\(name)"))
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                Spacer()
            }*/
    }
    
   private func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}
