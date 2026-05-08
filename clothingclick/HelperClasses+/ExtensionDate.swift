//
//  ExtensionDate.swift
//  clothingclick
//
//  Created by DavidBisht on 08/05/26.
//

import Foundation

extension Date {
    
    func toTimeString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: self)
    }
}
