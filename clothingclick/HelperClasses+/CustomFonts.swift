//
//  CustomFonts.swift
//  clothingclick
//
//  Created by DavidBisht on 20/04/26.
//

import Foundation
import SwiftUI

enum AppFont: String {
    case light = "Roboto-Light"
    case medium = "Roboto-Medium"
    case regular = "Roboto-Regular"
    case bold = "Roboto-Bold"
    case semibold = "Roboto-SemiBold"
    
    func uiFont(size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size)!
    }
    
    func font(size: CGFloat) -> Font {
        return Font.custom(self.rawValue, size: size)
    }
    
    func font(size: CGFloat, relativeTo: Font.TextStyle) -> Font {
        return Font.custom(self.rawValue, size: size, relativeTo: relativeTo)
    }
        
    func identifier() -> String {
        return self.rawValue
    }
    
}
