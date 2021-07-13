//
//  ChartVM.swift
//  CryFiat
//
//  Created by Jan Miklas on 12.07.2021.
//

import Combine
import Foundation
import SwiftUI

class ChartVM: ObservableObject {
    @Published var chartData: [Double] = []
    @Published var trimValue: CGFloat = 0
    private var cancellable = Set<AnyCancellable>()
    private let chartDataService = ChartDataService.shared
    
    var maxVal: Double = 0
    var minVal: Double = 0
    var midVal: Double = 0
    
    init() {
        chartDataService.$chartData
            .sink { [unowned self] chartData in
                self.chartData = chartData ?? []
                self.setupChart()
            }
            .store(in: &cancellable)
    }
    
    private func setupChart() {
        maxVal = chartData.max() ?? 0
        minVal = chartData.min() ?? 0
        midVal = maxVal-minVal
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.linear(duration: 1)) {
                self.trimValue = 1.0
            }
        }
    }
    
    func getChartData(coin: String, currency: Currency, days: String) {
        chartData = []
        trimValue = 0
        chartDataService.getChartData(coin: coin, currency: currency, days: days)
     }
}
