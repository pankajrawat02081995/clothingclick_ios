//
//  ComponentsViews.swift
//  clothingclick
//
//  Created by DavidBisht on 26/04/26.
//


import Foundation

struct TextFieldFormatter {
    
    // MARK: - Card Number (XXXX XXXX XXXX XXXX)
    static func formatCardNumber(_ value: String) -> String {
        let digits = value.filter { $0.isNumber }
        let limited = String(digits.prefix(16))
        
        var result = ""
        for (index, char) in limited.enumerated() {
            if index != 0 && index % 4 == 0 {
                result += " "
            }
            result.append(char)
        }
        return result
    }
    
    // MARK: - Expiry (MM/YY)
    static func formatExpiry(_ value: String) -> String {
        let digits = value.filter { $0.isNumber }
        let limited = String(digits.prefix(4))
        
        if limited.count <= 2 {
            return limited
        }
        
        let month = limited.prefix(2)
        let year = limited.suffix(from: limited.index(limited.startIndex, offsetBy: 2))
        
        return "\(month)/\(year)"
    }
}
