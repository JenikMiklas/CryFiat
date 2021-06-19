//
//  HomeView.swift
//  CryFiat
//
//  Created by Jan Miklas on 19.06.2021.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(1...5, id:\.self) { item in
                            Text("$0")
                        }
                    }
                }
            }
            .navigationTitle("Ahoj")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
