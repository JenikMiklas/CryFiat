//
//  UIApplication + Extension.swift
//  CryFiat
//
//  Created by Jan Miklas on 14.06.2021.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    /// Hide kyboard.
    /// ```
    /// Keyboard hides after calling this function.
    /// ```
    func hideKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
