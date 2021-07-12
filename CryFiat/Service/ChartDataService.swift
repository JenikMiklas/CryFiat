//
//  ChartDataService.swift
//  CryFiat
//
//  Created by Jan Miklas on 12.07.2021.
//

import Combine
import Foundation
import SwiftUI

final class ChartDataService {
    static let shared = ChartDataService()
    
    @Published var chartData:[Double]?
    
    private var subscription: AnyCancellable?
    
    private init() {}
    
    func getChartData(coin: String, currency: Currency) {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin)/market_chart?vs_currency=\(currency.rawValue)&days=7") else {
             fatalError("Wrong URL to get Top Market Coins")
        }
        subscription = DownloadManager.downloadFrom(url: url)
            .decode(type: ChartData.self, decoder: JSONDecoder())
            .map{ chartData -> [Double] in
                var arr = [Double]()
                for price in chartData.prices {
                    arr.append(price[1])
                }
                return arr
            }
            .sink(receiveCompletion: DownloadManager.Completion,
                  receiveValue: { [unowned self] (chartData) in
                    self.chartData = chartData
                    self.subscription?.cancel()
            })
    }
}
