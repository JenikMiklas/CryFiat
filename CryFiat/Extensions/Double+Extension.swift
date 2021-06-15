//
//  Double+Extension.swift
//  CryFiat
//
//  Created by Jan Miklas on 15.06.2021.
//

import Foundation

extension Double {
    /// ```
    /// Coverts a Double into a Coin with 2-6 decimal places.
    /// ```
    private var coinFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.currencyCode = "EUR"
        formatter.currencySymbol = "€"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    func coinStringValue() -> String {
        let value = NSNumber(value: self)
        return coinFormatter.string(from: value) ?? "0"
    }
    
    func coinNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    func coinPercentString() -> String {
        return coinNumberString() + " %"
    }
}
