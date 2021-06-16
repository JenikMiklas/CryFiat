//
//  CardSizeViewModifier.swift
//  CryFiat
//
//  Created by Jan Miklas on 16.06.2021.
//

import Foundation
import SwiftUI

struct CardSizeViewModifier: ViewModifier {
    let chooseCardSize: Bool
    func body(content: Content) -> some View {
        content
            .offset(y: chooseCardSize ? UIScreen.main.bounds.height/2-95 : UIScreen.main.bounds.height)
            .transition(.move(edge: .bottom))
            .animation(.default)
            .zIndex(99)
    }
}

extension View  {
    func cardSelection(show: Bool) -> some View {
        self.modifier(CardSizeViewModifier(chooseCardSize: show))
    }
}
