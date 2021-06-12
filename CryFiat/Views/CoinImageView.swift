//
//  CoinImageView.swift
//  CryFiat
//
//  Created by Jan Miklas on 12.06.2021.
//

import SwiftUI

struct CoinImageView: View {
    
    @StateObject var coinImageVM: CoinImageVM
    
    init(imageUrl: String) {
        _coinImageVM = StateObject(wrappedValue: CoinImageVM(urlString: imageUrl))
    }
    
    var body: some View {
        if let image = coinImageVM.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
        } else {
            ProgressView()
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(imageUrl: "")
            .previewLayout(.sizeThatFits)
            .frame(width: 50, height: 50)
    }
}
