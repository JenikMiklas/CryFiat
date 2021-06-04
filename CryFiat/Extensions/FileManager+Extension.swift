//
//  FileManager+Extension.swift
//  CryFiat
//
//  Created by Jan Miklas on 22.05.2021.
//

import Foundation
import UIKit

extension FileManager {
    static var dataDirURL: URL {
        return self.default.urls(for: SearchPathDirectory.documentDirectory, in: .userDomainMask).first!
    }
    
    func saveJson(content: String, fileName: String, completion: (Error) -> Void) {
        let url = Self.dataDirURL.appendingPathComponent(fileName)
        do {
            try content.write(to: url, atomically: true, encoding: .utf8)
        } catch {
            completion(error)
        }
    }
    
    func saveCryptocurrencyToken(image: UIImage, fileName: String, completion: (Error) -> Void) {
        if let data = image.pngData() {
            let url = Self.dataDirURL.appendingPathComponent("\(fileName).png")
            do {
                try data.write(to: url)
            } catch {
                completion(error)
            }
        } else {
            return
        }
    }
    
    func dataJsonExists(file: String) -> Bool {
        print(Self.dataDirURL)
        return fileExists(atPath: Self.dataDirURL.appendingPathComponent(file).path)
    }
    
    func loadImage(name: String) -> UIImage {
        do {
            let data = try Data(contentsOf: Self.dataDirURL.appendingPathComponent("\(name).png"))
            return UIImage(data: data)!
        } catch  {
            return UIImage(systemName: "questionmark")!
        }
    }
}
