//
//  APICryptoService.swift
//  CryFiat
//
//  Created by Jan Miklas on 21.05.2021.
//

import Combine
import Foundation
import UIKit

public class APICryptoService {
    public static let shared = APICryptoService()
    private var cancellable = Set<AnyCancellable>()
    
    public enum APIError: Error {
        case error(_ errorString: String)
        case urlError(_ errorString: String)
    }
    
    private init() {}
    
    func fetchFiat() -> AnyPublisher<[String], APIError> {
        return URLSession.shared.dataTaskPublisher(for: URLRequest(url: URL(string: "https://api.coingecko.com/api/v3/simple/supported_vs_currencies")!))
            .map { $0.data }
            .decode(type: [String].self, decoder: JSONDecoder())
            .mapError({ error in
                APIError.error("Decoding error")
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchCryptocurrencies() -> AnyPublisher<[Cryptocurrency], APIError> {
        return URLSession.shared.dataTaskPublisher(for: URLRequest(url: URL(string: "https://api.coingecko.com/api/v3/coins/list?include_platform=false")!))
            .map { $0.data }
            .decode(type: [Cryptocurrency].self, decoder: JSONDecoder())
            .mapError({ error in
                APIError.error("Decoding error")
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchCryptocurrenciesDetail(for id: String) -> AnyPublisher<CryptoTokenDetail, APIError> {
        return URLSession.shared.dataTaskPublisher(for: URLRequest(url: URL(string: "https://api.coingecko.com/api/v3/coins/\(id)?localization=true&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false")!))
            .map { $0.data }
            .decode(type: CryptoTokenDetail.self, decoder: JSONDecoder())
            .mapError({ error in
                APIError.error("Decoding error")
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchCryptocurrencyImage(url: String) -> AnyPublisher<UIImage, APIError> {
        return URLSession.shared.dataTaskPublisher(for: URL(string: url)!)
            .map { $0.data }
            .compactMap {
               UIImage(data: $0)
            }
            .mapError({ error in
                APIError.error("Decoding error")
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
