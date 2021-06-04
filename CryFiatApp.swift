//
//  CryFiatApp.swift
//  CryFiat
//
//  Created by Jan Miklas on 21.05.2021.
//

import SwiftUI

@main
struct CryFiatApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AppViewModel())
        }
    }
}
