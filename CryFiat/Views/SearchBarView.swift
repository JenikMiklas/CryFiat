//
//  SearchBarView.swift
//  CryFiat
//
//  Created by Jan Miklas on 14.06.2021.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var findToken: String
    
    var body: some View {
            TextField("search token", text: $findToken)
                .textFieldStyle(PlainTextFieldStyle())
                .disableAutocorrection(true)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(.secondary)
                        .onTapGesture {
                            findToken = ""
                            UIApplication.shared.hideKeyboard()
                        },
                    alignment: .trailing)
        .padding()
        .background(Color.gray.opacity(0.2))
        .clipShape(Capsule())
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(findToken: .constant("xrp"))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
