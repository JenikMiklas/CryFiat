//
//  LaunchView.swift
//  CryFiat
//
//  Created by Jan Miklas on 20.07.2021.
//

import SwiftUI

struct LaunchView: View {
    var body: some View {
        VStack {
            Image("launchscreen")
                .resizable()
                .scaledToFit()
            HStack {
                Spacer()
                Text("Powered by")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding(.trailing)
            }.offset(y:30)
            HStack {
                Image("coingecko")
                    .resizable()
                    .frame(width: 100, height: 100)
                Text("CoinGecko")
                    .font(.system(size: 50, weight: .semibold, design: .default))
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .background(Color.secondary.opacity(0.5))
        .ignoresSafeArea()
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
            
    }
}
