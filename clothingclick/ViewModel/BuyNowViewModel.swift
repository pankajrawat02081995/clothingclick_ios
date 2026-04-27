//
//  BuyNowViewModel.swift
//  clothingclick
//
//  Created by DavidBisht on 26/04/26.
//

import SwiftUI
import PassKit
import Combine

enum DeliveryType: String, CaseIterable {
    case ship = "Ship"
    case pickup = "Pickup"
    
    var imageString: String {
        return self == .ship ? "ship" : "pickup"
    }
}

class BuyNowViewModel: ObservableObject {
    
    // MARK: - Product
      @Published var productName: String = "White Tshirt"
      @Published var price: Double = 140.0
      @Published var size: String = "XXL"
      @Published var condition: String = "New"
    
      @Published var selectedSize: String = ""
    
    // MARK: - Delivery
    @Published var selectedDelivery: DeliveryType = .pickup
    
    // MARK: - Address
    @Published var country = ""
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var address = ""
    @Published var city = ""
    @Published var state = ""
    @Published var postalCode = ""
    @Published var province = ""
    
    //--Optional--
    @Published var phone = ""
    @Published var company = ""
    @Published var apartment = ""
    
    // MARK: - Payment
    @Published var cardNumber = ""
    @Published var expiry = ""
    @Published var cvv = ""
    @Published var email = ""
    @Published var name = ""
    @Published var cvc = ""
    @Published var isBillingSame = true
    
    // MARK: - UI State
    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var showApplePay = false
    
    // MARK: - Saved Address
    @Published var savedAddresses: [Address] = []
    @Published var selectedAddress: Address?
    
    
  
    
    var totalPrice: String {
        "$\(price)"
    }
    
    @Published var cardError: String?
    @Published var expiryError: String?

    func validateCard() {
        let digits = cardNumber.replacingOccurrences(of: " ", with: "")
        
        if digits.count < 16 {
            cardError = "Card number must be 16 digits"
        } else {
            cardError = nil
        }
    }

    func validateExpiry() {
        if expiry.count < 5 {
            expiryError = "Invalid expiry date"
        } else {
            expiryError = nil
        }
    }
    
    // MARK: - Validation
    func validate() -> Bool {
        if selectedDelivery == .ship {
            guard !firstName.isEmpty,
                  !address.isEmpty,
                  !city.isEmpty else {
                errorMessage = "Please fill all required fields"
                return false
            }
        }
        
        if cardNumber.count < 12 {
            errorMessage = "Invalid card number"
            return false
        }
        
        errorMessage = nil
        return true
    }
    
    // MARK: - API Call
    func checkout() async {
        guard validate() else { return }
        
        isLoading = true
        
        do {
            try await Task.sleep(nanoseconds: 2_000_000_000) // simulate API
            
            print("✅ Order placed successfully")
        } catch {
            errorMessage = "Something went wrong"
        }
        
        isLoading = false
    }
    
    // MARK: - Apple Pay
    func startApplePay() {
        showApplePay = true
    }
    
}
