//
//  FileService.swift
//  CryFiat
//
//  Created by Jan Miklas on 13.06.2021.
//

import Foundation
import SwiftUI

final class FileService: FileManager {
    
    static let shared = FileService()
    
    private override init () {
        super.init()
        print(getDirectory())
    }
    
    private func getDirectory() -> URL {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }
    
    private func directoryExists(name: String) -> Bool {
        return FileManager.default.fileExists(atPath: getDirectory().appendingPathComponent(name).path)
    }
    
    private func CreateDirectory(directory dir: String) {
        do {
            try FileManager.default.createDirectory(at: getDirectory().appendingPathComponent(dir), withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("🗂 Unable to create directory.")
        }
    }
    
    private func saveImage(url: URL, data: Data) {
        do {
            try data.write(to: url)
        } catch  {
            print("💾 Error saving image.")
        }
    }
    
    func cacheImage(directory dir: String = "cachedImages", name: String, image: UIImage) {
        if !directoryExists(name: dir) {
            CreateDirectory(directory: dir)
        }
        let url = getDirectory().appendingPathComponent(dir).appendingPathComponent(name + ".png")
        if let pngData = image.pngData() {
            saveImage(url: url, data: pngData)
        } else if let jpegData = image.jpegData(compressionQuality: 0.8) {
            saveImage(url: url, data: jpegData)
        } else {
            print("Unable decode data from given image \(name)")
        }
    }
    
    func loadCachedImage(dir: String = "cachedImages", name: String) -> UIImage? {
        let url = getDirectory().appendingPathComponent(dir).appendingPathComponent(name + ".png")
        do {
            let data = try Data(contentsOf: url)
            return UIImage(data: data)
        } catch {
            print("📸 Unable to load Image.")
            return nil
        }
    }
}
