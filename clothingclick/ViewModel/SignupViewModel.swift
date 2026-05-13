//
//  SignupViewModel.swift
//  clothingclick
//
//  Created by DavidBisht on 13/05/26.
//

import Combine

class SignupViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var name: String = ""
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var hidePassword: Bool = true
    @Published var confirmPassword: String = ""
    @Published var hideConfirmPassword: Bool = true
    
    private let passwordValidator = PasswordValidator()
    private let emailValidator = EmailValidator()
    
    var passwordValidationStatus: PasswordStatus {
        passwordValidator.validate(password: password)
    }
}
