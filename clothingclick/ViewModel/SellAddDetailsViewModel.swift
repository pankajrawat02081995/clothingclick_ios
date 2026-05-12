//
//  SellAddDetailsViewModel.swift
//  clothingclick
//
//  Created by DavidBisht on 11/05/26.
//

import Combine
import SwiftUI

class SellAddDetailsViewModel: ObservableObject {
    // MARK: - Address
    @Published var brandName = ""
    @Published var productTitle = ""
    @Published var productPhotos: [UIImage] = []
    @Published var productDescription = ""
    @Published var productPrice = ""
    @Published var sellLocation = ""
    
    @Published var department: String = ""
    @Published var category: String = ""
    @Published var subcategory: String = ""
    @Published var size: String = ""
    @Published var condition: String = ""
    @Published var colors: [String] = []
    @Published var style: String = ""
    
    @Published var error: String?
    @Published var showError: Bool = false

    
    func validate() -> Bool {
        var isValid: Bool = false
        if style.isEmpty {
            error = "Please select a style"
        } else if brandName.isEmpty {
            error = "Please add a brand"
        } else if productTitle.isEmpty {
        } else if productPhotos.count == 0 {
            error = "Please take a photo"
        } else if productDescription.isEmpty {
            error = "Please add a description"
        } else if productPrice.isEmpty || Int(productPrice) == 0 {
            error = "Please add some valid price"
        } else if sellLocation.isEmpty {
            error = "Please take a location"
        } else {
            isValid = true
        }
        return isValid
    }
    
    func fetchProductDetails() -> Product {
        return Product(
            name: productTitle,
            price:Int(productPrice) ?? 0,
            image: "",
            size: size,
            condition: condition,
            location: sellLocation,
            description: productDescription,
            sellerName: "Jessica Milan",
            sellerImage: "p3",
            department: department,
            category: category,
            subcategory: subcategory,
            colors: colors,
            style: style
        )
    }
}
