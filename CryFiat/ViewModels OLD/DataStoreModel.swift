//
//  CryFiatViewModel.swift
//  CryFiat
//
//  Created by Jan Miklas on 21.05.2021.
//

import Combine
import Foundation
import SwiftUI

class DataStoreModel: ObservableObject {
    //MARK: @PUBLISHERS
    @Published var tokenFind = ""
    @Published var errorMessage = ""
    @Published var tokenList = [Cryptocurrency]()
    @Published var tokenDetails = [CryptoTokenDetail]() {
        didSet {
            print("TOKEN LIST: \(tokenDetails)")
        }
    }
    @Published var tokenImages = [UIImage](){
        didSet {
            print("IMAGE LIST: \(tokenImages)")
        }
    }
    
    @Published var fiatArr = [String]() {
        didSet {
            if !(FileManager.default.dataJsonExists(file: JsonFile.fiatData.rawValue)) {
                saveFile(file: fiatArr, fileName: JsonFile.fiatData.rawValue)
            }
        }
    }
    
    @Published var tokensTopMarket = [CryptoTokenMarket]() {
        didSet {
            print(tokensTopMarket)
        }
    }
    @Published var topImages = [(String, UIImage)](){
        didSet {
            //print("IMAGE LIST: \(topImages)")
        }
    }
    
    private var tokens = [Cryptocurrency]() {
        didSet {
            if !(FileManager.default.dataJsonExists(file: JsonFile.cryptoData.rawValue)) {
                saveFile(file: tokens, fileName: JsonFile.cryptoData.rawValue)
            }
        }
    }
    
    //MARK: APISERVICE
    private let APIService = APICryptoService.shared
    
    private var loadFiat = Just(FileManager.dataDirURL.appendingPathComponent(JsonFile.fiatData.rawValue))
    private var loadCryptoTokens = Just(FileManager.dataDirURL.appendingPathComponent(JsonFile.cryptoData.rawValue))
    
    private var subscriptions = Set<AnyCancellable>()

    
    init() {
        
        downloadTopmarket()
        
        //MARK: GET ALL FIAT LIST
        if !(FileManager.default.dataJsonExists(file: JsonFile.fiatData.rawValue)) {
            downloadFiat()
        } else {
            loadFiat
                .subscribe(on: DispatchQueue(label: "Background queue"))
                .tryMap { url in
                    try Data(contentsOf: url)
                }
                .decode(type: [String].self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("Fiat loaded")
                    case .failure(_):
                        print("Fiat Not loaded")
                    }
                } receiveValue: { [unowned self] data in
                    print(data)
                    self.fiatArr = data
                }
                .store(in: &subscriptions)
            
        }
        
        //MARK: GET ALL CRYPTO LIST
        /*
        if !(FileManager.default.dataJsonExists(file: JsonFile.cryptoData.rawValue)) {
            downloadCryptocurrencies()
        } else {
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
                } receiveValue: { [unowned self] data in
                    print(data)
                    self.tokens = data
                }
                .store(in: &subscriptions)
        }
        */
        
        
        
        
        //MARK: FIND CRYPTO TOKEN ON WEB
        /*
        $tokenFind
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { _ in
                
            } receiveValue: { [unowned self] token in
                self.findCryptoToken(token: token)
            }
            .store(in: &subscriptions)
 */
    }
    
    public func findCryptoToken(token t: String) {
         tokenList = tokens.filter{ $0.id.lowercased() == t.lowercased() || $0.name.lowercased() == t.lowercased() || $0.symbol.lowercased() == t.lowercased()
         }
        tokenList.publisher
            .removeDuplicates()
            .flatMap { [unowned self] in
                self.APIService.fetchCryptocurrenciesDetail(for: $0.id)
            }
            .scan([CryptoTokenDetail]()) { (all, next) in
                all + [next]
            }
            .sink { [unowned self] completion in
                switch completion {
                case .finished:
                    print("Fetch success")
                case .failure(let error):
                    print(error)
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { [unowned self] data in
                self.tokenDetails = data
                self.downloadCryptocurrencyImage(token: t)
            }
            .store(in: &subscriptions)
    }
    //MARK: SAVE TO DISC
    public func saveImageToken(image: UIImage, name: String) {
        FileManager.default.saveCryptocurrencyToken(image: image, fileName: name) { error in
            print(error.localizedDescription)
        }
    }
    
    private func saveFile<T: Encodable>(file: T, fileName: String) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(file)
            if let jsonString = String(data: data, encoding: .utf8) {
                FileManager().saveJson(content: jsonString, fileName: fileName) { error in
                    print("Saving error: \(error.localizedDescription)")
                }
            }
        } catch {
            print("Coding Error")
        }
    }
    
    //MARK: PRIVATE FUNC DOWNLOADS
    private func downloadFiat() {
        APIService.fetchFiat().sink { completion in
            switch completion {
            case .finished:
                print("Fetch success")
            case .failure(let error):
                print(error)
            }
        } receiveValue: { [unowned self] data in
            self.fiatArr = data
            print(data)
        }
        .store(in: &subscriptions)
    }
    
    private func downloadCryptocurrencies() {
        APIService.fetchCryptocurrencies().sink { completion in
            switch completion {
            case .finished:
                print("Fetch success")
            case .failure(let error):
                print(error)
            }
        } receiveValue: { [unowned self] data in
            self.tokens = data
        }
        .store(in: &subscriptions)
    }
    
    private func downloadCryptocurrencyImage(token t: String) {
        tokenDetails.publisher
            .flatMap { [unowned self] str in
                self.APIService.fetchCryptocurrencyImage(url: str.image.large)
            }
            .scan([UIImage]()) { (all, next) in
                all + [next]
            }
            .sink { completion in
                switch completion {
                case .finished:
                    print("Image success")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [unowned self] data in
                self.tokenImages = data
            }
            .store(in: &subscriptions)

            
    }
    
    func downloadTopCryptocurrencyImage() {
        tokensTopMarket.publisher
            .flatMap { [unowned self] token in
                self.APIService.fetchTopCryptocurrencyImage(url: token.image, token: token.id)
            }
            .scan([(String, UIImage)]()) { (all, next) in
                return all + [next]
            }
            .sink { completion in
                switch completion {
                case .finished:
                    print("Image success")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [unowned self] data in
                self.topImages = data
            }
            .store(in: &subscriptions)
    }
    
    private var page = 1
    
    private func downloadTopmarket() {
        APIService.fetchTopMarket(page: page)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Fetch success Top Market")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [unowned self] data in
                self.tokensTopMarket += data
                if page < 4 {
                    self.page += 1
                    print(self.page)
                    self.downloadTopmarket()
                } else {
                    print(self.tokensTopMarket.count)
                    self.downloadTopCryptocurrencyImage()
                }
            }
            .store(in: &subscriptions)
    }
}
