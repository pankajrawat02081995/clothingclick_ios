//
//  LoginViewModel.swift
//  clothingclick
//
//  Created by DavidBisht on 13/05/26.
//

import Combine

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var hidePassword: Bool = true
    
    private let passwordValidator = PasswordValidator()
    private let emailValidator = EmailValidator()
    
    var passwordValidationStatus: PasswordStatus {
        passwordValidator.validate(password: password)
    }
}
