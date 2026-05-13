//
//  EmailValidator.swift
//  clothingclick
//
//  Created by DavidBisht on 13/05/26.
//

import Foundation

class EmailValidator {
    // Modern Swift Regex Literal
    private let emailRegex = /^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}$/

    func isValid(_ email: String) -> Bool {
        // We use 'wholeMatch' because the entire string must be a valid email
        return email.wholeMatch(of: emailRegex) != nil
    }
}
