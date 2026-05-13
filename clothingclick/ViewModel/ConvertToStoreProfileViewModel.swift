//
//  ConvertToStoreProfileViewModel.swift
//  clothingclick
//
//  Created by DavidBisht on 13/05/26.
//

import Combine

class ConvertToStoreProfileViewModel: ObservableObject {
    @Published var storeName: String = ""
    @Published var storeAddress: String = ""
    @Published var phoneNumber: String = ""
    @Published var email: String = ""
    @Published var website: String = ""
    @Published var message: String = ""
    
    private let emailValidator = EmailValidator()
   
}
