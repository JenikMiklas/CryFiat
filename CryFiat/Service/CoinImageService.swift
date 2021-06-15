//
//  CoinImageService.swift
//  CryFiat
//
//  Created by Jan Miklas on 12.06.2021.
//

import Combine
import Foundation
import SwiftUI

/// Coins images.
/// ```
/// Getting image for individual coin.
/// ```
final class CoinImageService {
    
    @Published var image: UIImage?
    
    private var subscription: AnyCancellable?
    private let fileService = FileService.shared
    
    init(urlString: String, coinName: String) {
        if let uiImage = fileService.loadCachedImage(name: coinName) {
            image = uiImage
        } else {
            getCoinImage(urlString: urlString, coinName: coinName)
        }
    }
    
    private func getCoinImage(urlString: String, coinName: String) {
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
                if let uiImage = coinImage {
                    fileService.cacheImage(name: coinName, image: uiImage)
                }
                self.subscription?.cancel()
            })
    }
}

