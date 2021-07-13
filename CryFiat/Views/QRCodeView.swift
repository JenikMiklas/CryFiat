//
//  QRCodeView.swift
//  CryFiat
//
//  Created by Jan Miklas on 13.07.2021.
//

import SwiftUI

struct QRCodeView: View {
    
    @Binding var address: String
    
    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()
    var body: some View {
        Image(uiImage: generateQRCode(from: "\(address)"))
            .interpolation(.none)
            .resizable()
            .scaledToFit()
    }
    
   private func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct QRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeView(address: .constant("ripple:rUwYKnpcDr9PLfE9DzZ6r8P3qpKbqv4SyA?amount=10&message=New house"))
    }
}
