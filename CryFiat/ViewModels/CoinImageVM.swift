//
//  CoinImageVM.swift
//  CryFiat
//
//  Created by Jan Miklas on 12.06.2021.
//

import Combine
import Foundation
import SwiftUI

final class CoinImageVM: ObservableObject {
    
    @Published var image: UIImage?
    private let imageService: CoinImageService
    private var cancellable = Set<AnyCancellable>()
    
    init(urlString: String, coinName: String) {
        self.imageService = CoinImageService(urlString: urlString, coinName: coinName)
        imageService.$image
            .sink { [unowned self] image in
                self.image = image
            }
            .store(in: &cancellable)
    }
}
