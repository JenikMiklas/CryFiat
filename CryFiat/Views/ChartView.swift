//
//  ChartView.swift
//  CryFiat
//
//  Created by Jan Miklas on 24.06.2021.
//

import SwiftUI

struct ChartView: View {
    
    @ObservedObject var homeVM: HomeVM
    @State private var priceData: [Double] = [Double]()
    @State private var maxVal: Double = 0
    @State private var minVal: Double = 0
    @State private var midVal: Double = 0
    @State private var lastUpdate: Date = Date()
    @State private var startDate: Date = Date ()
    @State private var trimValue: CGFloat = 0
    @Binding var loadingChart: Bool
    
    var body: some View {
        VStack {
            if !loadingChart {
            chartView
                .background(background)
                .overlay(overlay, alignment: .leading)
            timeInterval
            } else {
                ProgressView()
                 .frame(height: 200)
            }
        }
        .onReceive(homeVM.$chartData, perform: { chartData in
            trimValue = 0
            priceData = chartData ?? [Double]()
            maxVal = priceData.max() ?? 0
            minVal = priceData.min() ?? 0
            midVal = maxVal-minVal
            lastUpdate = Date().dateFrom(string: homeVM.selectedCoin?.lastUpdated ?? "")
            startDate = lastUpdate.addingTimeInterval(-7*24*3600)
            loadingChart.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.linear(duration: 1)) {
                    trimValue = 1
                }
            }
        })
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(homeVM: HomeVM(), loadingChart: .constant(false))
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
            .trim(from: 0, to: trimValue)
            .stroke(priceData.last ?? 0 > priceData.first ?? 0 ? Color.green:Color.red, lineWidth: 3)
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
            Text(maxVal.coinNumberString())
            Spacer()
            Text((midVal/2 + minVal).coinNumberString())
            Spacer()
            Text(minVal.coinNumberString())
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
