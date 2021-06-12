//
//  CoinImageService.swift
//  CryFiat
//
//  Created by Jan Miklas on 12.06.2021.
//

import Combine
import Foundation
import SwiftUI

final class CoinImageService {
    
    @Published var image: UIImage?
    
    private var subscription: AnyCancellable?
    
    init(urlString: String) { getCoinImage(urlString: urlString) }
    
    private func getCoinImage(urlString: String) {
        guard let url = URL(string: urlString) else {
             fatalError("Wrong URL to get Top Market Coins")
        }
        subscription = DownloadManager.downloadFrom(url: url)
            .tryMap { data -> UIImage? in
                UIImage(data: data)
            }
            .sink(receiveCompletion: DownloadManager.Completion,
                  receiveValue: { [unowned self] (coinImage) in
                self.image = coinImage
                self.subscription?.cancel()
            })
    }
}

