//
//  DetailContent.swift
//  CryFiat
//
//  Created by Jan Miklas on 27.05.2021.
//

import CoreImage.CIFilterBuiltins
import SwiftUI

struct DetailContent: View {
    let token: Cryptocurrency
    @State private var address: String = ""
    @State private var amount: String = ""
    @State private var tag: String = ""
    
    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        VStack {
            TextField("address", text: $address)
                .textContentType(.URL)
                .padding()
                .onAppear {
                    address = token.address?.first ?? ""
                }
                .navigationBarItems(trailing:Image(token.id).resizable().frame(width: 35, height: 35)
                )
            TextField("amount", text: $amount)
                .keyboardType(.numbersAndPunctuation)
                .padding()
            TextField("tag", text: $tag)
                .padding()
            Image(uiImage: generateQRCode(from: "\(address)"))
                .interpolation(.none)
                .resizable()
                .scaledToFit()
        }
    }
    
    private func generateQRCode(from string: String) -> UIImage {
        let stringQR = token.id+":"+string+"?dt="+tag+"&amount="+amount
        print(stringQR)
        let data = Data(stringQR.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct DetailContent_Previews: PreviewProvider {
    static var previews: some View {
        DetailContent(token: Cryptocurrency(id: "ripple", symbol: "xrp", name: "XRP", address: ["rUwYKnpcDr9PLfE9DzZ6r8P3qpKbqv4SyA"]))
    }
}
