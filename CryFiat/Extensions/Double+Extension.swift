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
        formatter.numberStyle = .decimal
        formatter.locale = .current
        //formatter.currencyCode = Currency.eur.rawValue
        //formatter.currencySymbol = "€"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    func coinStringValue() -> String {
        let value = NSNumber(value: self)
        return coinFormatter.string(from: value) ?? "?"
    }
    
    func coinNumberString() -> String {
        var val: String
        if self <= 0.1 {
            val = String(format: "%.5f", self)
        } else if self > 100 {
            val = String(format: "%.0f", self)
        } else if self > 10 {
            val = String(format: "%.1f", self)
        } else {
            val = String(format: "%.2f", self)
        }
        return val
    }
    
    func coinPercentString() -> String {
        return coinNumberString() + " %"
    }
    
    func coinStringSymbol(currency: Currency) -> String {
        
        if currency.symbol == "" {
            return coinNumberString() + " " + currency.rawValue.uppercased()
        } else {
            return currency.symbol + " " + coinNumberString()
        }
    }
    
    func coinStringLongSymbol(currency: Currency) -> String {
        
        if currency.symbol == "" {
            return coinStringValue() + " " + currency.rawValue.uppercased()
        } else {
            return currency.symbol + " " + coinStringValue()
        }
    }
}
