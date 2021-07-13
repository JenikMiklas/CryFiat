//
//  CoinSizeCardView.swift
//  CryFiat
//
//  Created by Jan Miklas on 15.06.2021.
//

import SwiftUI

struct CoinSizeCardView: View {
    
    @Binding var cardSize: CoinCardSize
    @Binding var chooseCardSize: Bool
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .frame(height: 200)
                .cornerRadius(20)
            VStack {
                Text("Coin card size")
                    .font(.headline)
                HStack {
                    Button(action: {
                        cardSize = .small
                        chooseCardSize.toggle()
                    }, label: {
                        VStack {
                            Circle()
                                .frame(width: 25, height: 25)
                            Rectangle().frame(width: 10, height: 5)
                            Rectangle().frame(width: 20, height: 5)
                        }
                        .frame(width: CoinCardSize.small.rawValue/2, height: 100/2)
                        .padding(9)
                        .border(Color.secondary, width: 1).cornerRadius(5)
                    })
                    Divider()
                        .frame(height: 75)
                    Button(action: {
                        cardSize = .medium
                        chooseCardSize.toggle()
                    }, label: {
                        VStack {
                            HStack(alignment: .center) {
                                VStack(alignment:.leading) {
                                    Rectangle().frame(width: 10, height: 5)
                                    Rectangle().frame(width: 20, height: 5)
                                }
                                Spacer()
                                Circle()
                                    .frame(width: 25, height: 25)
                            }
                            .padding(.top, 2)
                            .padding(.trailing, 2)
                            .padding(.leading, 2)
                            Rectangle().frame(width: 30, height: 5)
                            Rectangle().frame(width: 30, height: 5)
                        }
                            
                        .frame(width: CoinCardSize.medium.rawValue/2, height: 150/2)
                        .padding(3)
                        .border(Color.secondary, width: 1).cornerRadius(5)
                    })
                    Divider()
                        .frame(height: 75)
                    Button(action: {
                        cardSize = .large
                        chooseCardSize.toggle()
                    }, label: {
                        VStack {
                            HStack(alignment: .center) {
                                VStack(spacing: 3) {
                                    Rectangle().frame(width: 20, height: 5)
                                    Rectangle().frame(width: 30, height: 5)
                                }
                                Spacer()
                                VStack(spacing: 3) {
                                    Rectangle().frame(width: 30, height: 5)
                                    Rectangle().frame(width: 50, height: 5)
                                    Rectangle().frame(width: 50, height: 5)
                                }
                                Spacer()
                                Circle()
                                    .frame(width: 25, height: 25)
                            }
                            .padding([.top, .leading,. trailing], 8)
                            Spacer()
                            HStack(alignment: .center) {
                                VStack(spacing: 3) {
                                    Rectangle().frame(width: 50, height: 5)
                                    Rectangle().frame(width: 50, height: 5)
                                }
                                Spacer()
                                VStack(spacing: 3) {
                                    Rectangle().frame(width: 50, height: 5)
                                    Rectangle().frame(width: 50, height: 5)
                                }
                            }
                            .padding([.top, .leading,. trailing], 8)
                            Spacer()
                        }
                        .frame(width: CoinCardSize.large.rawValue/2, height: 200/2)
                        .border(Color.secondary, width: 1).cornerRadius(5)
                    })
                }
                .foregroundColor(Color(.systemGray))
            }.offset(y: -20)
        }
    }
}
// MARK: PREVIEW
struct CoinSizeCardView_Previews: PreviewProvider {
    static var previews: some View {
        CoinSizeCardView(cardSize: .constant(CoinCardSize.small), chooseCardSize: .constant(true))
            .previewLayout(.sizeThatFits)
            .padding()
        CoinSizeCardView(cardSize: .constant(CoinCardSize.small), chooseCardSize: .constant(true))
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
