//
//  URLDownloadService.swift
//  CryFiat
//
//  Created by Jan Miklas on 12.06.2021.
//

import Combine
import Foundation

final class DownloadManager {
    
    public enum ServiceError: LocalizedError {
        case error
        case urlError (url: URL)
        
        var errorDescription: String? {
            switch self {
            case .error:
                return "🤬 Error!!!"
            case .urlError(url: let error):
                return "🤯 Wrong URL: \(error)"
            }
        }
    }
    
    static func downloadFrom(url: URL) -> AnyPublisher<Data, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { try handleURLResponse(output: $0, url: url) }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else { throw ServiceError.urlError(url: url) }
        return output.data
    }
    
    static func Completion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
