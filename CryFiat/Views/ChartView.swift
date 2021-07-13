//
//  ChartView.swift
//  CryFiat
//
//  Created by Jan Miklas on 24.06.2021.
//

import SwiftUI

enum Days: String, CaseIterable {
    case week = "7"
    case twoWeeks = "14"
    case month = "30"
    case threeMonths = "90"
    case year = "365"
}

struct ChartView: View {
    @StateObject var chartVM: ChartVM
    let coin: CoinsTokenMarket
    let currency: Currency
    @State private var lastUpdate: Date = Date()
    @State private var startDate: Date = Date ()
    @State private var days: Days = .week
    
    init(coin: CoinsTokenMarket, currency: Currency) {
        self.coin = coin
        self.currency = currency
        self._chartVM = StateObject(wrappedValue: ChartVM())
    }
    
    var body: some View {
        VStack {
            if chartVM.chartData.isEmpty {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                chartView
                    .background(background)
                    .overlay(overlay, alignment: .leading)
                timeInterval
            }
            rangeSegment
        }
        .onAppear {
            chartVM.getChartData(coin: coin.id, currency: currency, days: days.rawValue)
            lastUpdate = Date().dateFrom(string: coin.lastUpdated ?? "")
            if let day = Double(days.rawValue) {
                startDate = lastUpdate.addingTimeInterval(-day*24*3600)
            }
        }
        .onChange(of: days) { value in
            chartVM.getChartData(coin: coin.id, currency: currency, days: days.rawValue)
            if let day = Double(days.rawValue) {
                startDate = lastUpdate.addingTimeInterval(-day*24*3600)
            }
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: PreviewVM.coin, currency: Currency.eur)
            .frame(height: 200)
    }
}
// MARK: ChartView
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
    // MARK: background
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
    // MARK: timeInterval
    private var timeInterval: some View {
        HStack {
            Text(startDate.shortDateString())
            Spacer()
            Text(lastUpdate.shortDateString())
        }.font(.caption)
        .padding([.leading, .trailing])
    }
    // MARK: rangeSegment
    private var rangeSegment: some View {
        Picker("Range", selection: $days) {
            ForEach(Days.allCases, id: \.self) {
                switch $0 {
                case .week, .twoWeeks:
                    Text($0.rawValue) + Text(" d")
                case .month:
                    Text("1 m")
                case .threeMonths:
                   Text("3 m")
                case .year:
                    Text("1 y")
                }
            }
        }.pickerStyle(SegmentedPickerStyle()).padding([.leading, .trailing, .top])
    }
}
