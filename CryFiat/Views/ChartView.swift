//
//  ChartView.swift
//  CryFiat
//
//  Created by Jan Miklas on 24.06.2021.
//

import SwiftUI

struct ChartView: View {
    @StateObject var chartVM = ChartVM()
    let coin: CoinsTokenMarket
    let currency: Currency
    @State private var lastUpdate: Date = Date()
    @State private var startDate: Date = Date ()
    
    init(coin: CoinsTokenMarket, currency: Currency) {
        self.coin = coin
        self.currency = currency
    }
    
    var body: some View {
        VStack {
            chartView
                .background(background)
                .overlay(overlay, alignment: .leading)
            timeInterval
        }
        .onAppear {
            chartVM.getChartData(coin: coin.id, currency: currency)
            lastUpdate = Date().dateFrom(string: coin.lastUpdated ?? "")
            startDate = lastUpdate.addingTimeInterval(-7*24*3600)
        }
        .onDisappear {
            chartVM.chartData = []
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: PreviewVM.coin, currency: Currency.eur)
    }
}

extension ChartView {
    private var chartView: some View {
        GeometryReader { geo in
            Path { path in
                if chartVM.midVal != 0 {
                    for i in chartVM.chartData.indices {
                        let dx = geo.size.width / CGFloat(chartVM.chartData.count) * CGFloat(i+1)
                        let y = (1 - CGFloat((chartVM.chartData[i] - chartVM.minVal) / chartVM.midVal)) * geo.size.height
                        if i == 0 {
                            path.move(to: CGPoint(x: 0.0, y: y))
                        } else {
                            path.addLine(to: CGPoint(x: dx, y: y))
                        }
                    }
                }
            }
            .trim(from: 0, to: chartVM.trimValue)
            .stroke(chartVM.chartData.last ?? 0 > chartVM.chartData.first ?? 0 ? Color.green:Color.red, lineWidth: 3)
            .shadow(color: .primary.opacity(0.5), radius: 10, x: 0.0, y: 10)
        }
    }
    private var background: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    private var overlay: some View {
        VStack {
            Text(chartVM.maxVal.coinNumberString())
            Spacer()
            Text((chartVM.midVal/2 + chartVM.minVal).coinNumberString())
            Spacer()
            Text(chartVM.minVal.coinNumberString())
    }.font(.subheadline).padding(.leading)
    }
    private var timeInterval: some View {
        HStack {
            Text(startDate.shortDateString())
            Spacer()
            Text(lastUpdate.shortDateString())
        }.font(.caption)
        .padding([.leading, .trailing])
    }
}
