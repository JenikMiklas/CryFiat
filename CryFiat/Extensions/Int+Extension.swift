//
//  Int+Extension.swift
//  CryFiat
//
//  Created by Jan Miklas on 28.06.2021.
//

import Foundation

extension Int {
    func coinStringValue() -> String {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        return formatter.string(for: self) ?? "?"
    }
}
