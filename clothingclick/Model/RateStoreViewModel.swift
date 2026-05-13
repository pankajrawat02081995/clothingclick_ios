//
//  RateStoreViewModel.swift
//  clothingclick
//
//  Created by DavidBisht on 12/05/26.
//

import Combine
import SwiftUI

final class RateStoreViewModel: ObservableObject {

    @Published var description: String = ""
    @Published var selectedRating: Int = 0
    @Published var selectedImages: UIImage? = nil

    let store = StoreRatingModel(
        storeName: "From Another",
        username: "MariaJustinDias",
        description: "",
        rating: 0
    )

    func submitReview() {
        print("Review Submitted")
    }
}
