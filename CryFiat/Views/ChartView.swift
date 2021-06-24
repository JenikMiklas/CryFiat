//
//  ChartView.swift
//  CryFiat
//
//  Created by Jan Miklas on 24.06.2021.
//

import SwiftUI

struct ChartView: View {
    
    let priceData: [Double]
    
    init(coin: CoinsTokenMarket) {
        self.priceData = coin.sparklineIn7d?.price ?? [Double]()
    }
    
    var body: some View {
        Path { path in
            var dx = UIScreen.main.bounds.width / CGFloat(priceData.count)
            path.move(to: CGPoint(x: 0, y: priceData.first ?? 0))
            for i in 1..<priceData.count {
                dx *= CGFloat(i)
                path.addLine(to: CGPoint(x: dx, y: CGFloat(priceData[i])))
            }
        }
        .stroke(Color.black, lineWidth: 5)
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: PreviewVM.coin)
    }
}
