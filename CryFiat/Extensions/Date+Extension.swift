//
//  Date+Extension.swift
//  CryFiat
//
//  Created by Jan Miklas on 24.06.2021.
//

import Foundation

extension Date {
    
    private var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }
    
    func dateFrom(string: String) -> Date {
        return formatter.date(from: string) ?? Date()
    }
    
    func shortDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: self)
    }
}
