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
            VStack(alignment: .trailing, spacing: -20) {
                Text("Powered by")
                    .font(.system(size: 20, weight: .regular, design: .default))
                HStack {
                    Image("coingecko")
                        .resizable()
                        .frame(width: 100, height: 100)
                    Text("CoinGecko")
                        .font(.system(size: 40, weight: .semibold, design: .default))
                }
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .background(Color.gray)
        .ignoresSafeArea()
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
            
            
    }
}
