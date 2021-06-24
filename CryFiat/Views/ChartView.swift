//
//  ChartView.swift
//  CryFiat
//
//  Created by Jan Miklas on 24.06.2021.
//

import SwiftUI

struct ChartView: View {
    
    let priceData: [Double]
    private let maxVal: Double
    private let minVal: Double
    private let midVal: Double
    
    init(coin: CoinsTokenMarket) {
        self.priceData = coin.sparklineIn7d?.price ?? [Double]()
        self.maxVal = priceData.max() ?? 0
        self.minVal = priceData.min() ?? 0
        self.midVal = maxVal-minVal
    }
    
    var body: some View {
        chartView
            .background(
                VStack {
                    Divider()
                    Spacer()
                    Divider()
                    Spacer()
                    Divider()
                })
            .overlay(
                VStack {
                    Text(maxVal.coinStringValue())
                    Spacer()
                    Text(((maxVal-minVal)/2).coinStringValue())
                    Spacer()
                    Text(minVal.coinStringValue())
                }.font(.subheadline), alignment: .leading)
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: PreviewVM.coin)
    }
}

extension ChartView {
    private var chartView: some View {
        GeometryReader { geo in
            Path { path in
                for i in priceData.indices {
                    let dx = geo.size.width / CGFloat(priceData.count) * CGFloat(i+1)
                    let y = (1 - CGFloat((priceData[i] - minVal) / midVal)) * geo.size.height
                    if i == 0 {
                        path.move(to: CGPoint(x: 0, y: y))
                    }
                    path.addLine(to: CGPoint(x: dx, y: y))
                }
            }
            .stroke(priceData.last ?? 0 > priceData.first ?? 0 ? Color.green:Color.red, lineWidth: 3)
        }
    }
}
