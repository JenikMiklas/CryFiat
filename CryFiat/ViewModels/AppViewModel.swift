//
//  AppViewModel.swift
//  CryFiat
//
//  Created by Jan Miklas on 26.05.2021.
//

import Foundation
import Combine

class AppViewModel: ObservableObject {
    @Published var cryptoTokens = [Cryptocurrency]() {
        didSet {
            storeCryptoTokens()
        }
    }
    
    private var loadCryptoTokens = Just(FileManager.dataDirURL.appendingPathComponent(JsonFile.userCryptoData.rawValue))
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        loadCryptoTokens
            .subscribe(on: DispatchQueue(label: "Background queue"))
            .tryMap { url in
                try Data(contentsOf: url)
            }
            .decode(type: [Cryptocurrency].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Tokens loaded")
                case .failure(_):
                    print("Tokens Not loaded")
                }
            } receiveValue: { data in
                print(data)
                self.cryptoTokens = data
            }
            .store(in: &subscriptions)
    }
    
    private func storeCryptoTokens() {
       let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self.cryptoTokens)
            if let json = String(data: data, encoding: .utf8) {
                    FileManager().saveJson(content: json, fileName: JsonFile.userCryptoData.rawValue) { error in
                        print("Saving cryptoTokens error")
                    }
                }
            } catch {
                print(error.localizedDescription)
        }
    }
}
