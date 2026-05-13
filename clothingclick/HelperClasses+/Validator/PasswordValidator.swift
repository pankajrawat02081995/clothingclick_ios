//
//  PasswordValidator.swift
//  clothingclick
//
//  Created by DavidBisht on 13/05/26.
//

import Foundation

class PasswordValidator {
    // Matches 8 or more characters (the comma after 8 is the key)
    private let lengthRegex = /.{8,}/
    
    // 2. At least one uppercase letter
    private let uppercaseRegex = /[A-Z]/
    
    // 3. At least one number
    private let numberRegex = /[0-9]/

    func validate(password: String) -> PasswordStatus {
        PasswordStatus(
            isLengthValid: password.wholeMatch(of: lengthRegex) != nil,
            hasUppercase: password.contains(uppercaseRegex),
            hasNumber: password.contains(numberRegex)
        )
    }
}

// A simple struct to hold the results
struct PasswordStatus {
    var isLengthValid: Bool = false
    var hasUppercase: Bool = false
    var hasNumber: Bool = false
    
    var isValid: Bool {
        isLengthValid && hasUppercase && hasNumber
    }
}


extension String {
    var isValidPassword: Bool {
        let validator = PasswordValidator()
        return validator.validate(password: self).isValid
    }
}
