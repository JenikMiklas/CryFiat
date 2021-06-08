//
//  TestView.swift
//  CryFiat
//
//  Created by Jan Miklas on 06.06.2021.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(maxWidth: geo.size.width)
                    .aspectRatio(1.6, contentMode: .fit)
                    .padding([.leading, .trailing])
                    .foregroundColor(.secondary.opacity(0.5))
                Image("ripple")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width * 0.15)
                    .cornerRadius(geo.size.width * 0.15)
                    .offset(x: geo.size.width/2.8, y: -geo.size.height * 0.09)
                Text("XRP")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.primary)
                    .offset(x: geo.size.width/2.8, y: geo.size.height * 0.1)
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    Text("7")
                        .font(.title2)
                        .bold()
                    Text("#")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
                .foregroundColor(.primary)
                .offset(x: -geo.size.width/2.8, y: geo.size.height * 0.1)
                VStack {
                    Text("0.79 €")
                        .font(.largeTitle)
                        .bold()
                    HStack {
                        VStack(alignment:.leading) {
                            HStack(alignment: .firstTextBaseline) {
                                Text("max 24h:")
                                    .font(.caption2)
                                Text("0.80 €")
                                    .font(.caption)
                            }
                            HStack(alignment: .firstTextBaseline) {
                                Text("min 24h:")
                                    .font(.caption2)
                                Text("0.75 €")
                                    .font(.caption)
                            }
                        }
                        VStack(alignment:.leading) {
                            HStack(alignment: .firstTextBaseline) {
                                Text("Δ% 24h:")
                                    .font(.caption2)
                                Text("3.70 %")
                                    .font(.caption)
                            }
                            HStack(alignment: .firstTextBaseline) {
                                Text("Δ€ 24h:")
                                    .font(.caption2)
                                Text(" 0.028 €")
                                    .font(.caption)
                            }
                        }
                    }
                }
                HStack {
                    Text("updated:")
                    Text("2021-06-07T13:18:29.934Z")
                }
                .offset(y: geo.size.height * 0.13)
                .font(.caption2)
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TestView()
            TestView()
                .previewDevice("iPhone SE (2nd generation)")
        }
    }
}
