//
//  DiscoverViewModel.swift
//  clothingclick
//
//  Created by DavidBisht on 28/04/26.
//

import Combine
import SwiftUI

@MainActor
class DiscoverViewModel: ObservableObject {

    @Published var isLoading: Bool = true
    @Published var sections: [SectionModel] = []
    @Published var search = ""
    @Published var isLoaded: Bool = false
    let sampleProducts: [ItemModel] = [
        ItemModel(title: "Dress Shirt", image: "shirt1", price: "$140", isFavorite: false),
        ItemModel(title: "Dress Shirt", image: "shirt2", price: "$140", isFavorite: false),
        ItemModel(title: "Dress Shirt", image: "shirt3", price: "$140", isFavorite: false),
        ItemModel(title: "Dress Shirt", image: "shirt4", price: "$140", isFavorite: false)
    ]
    
    let sampleCategories: [ItemModel] = [
        ItemModel(title: "Top", image: "cat_top", price: nil, isFavorite: false),
        ItemModel(title: "Bottoms", image: "cat_bottom", price: nil, isFavorite: false),
        ItemModel(title: "Outerwear", image: "cat_outer", price: nil, isFavorite: false),
        ItemModel(title: "Footwear", image: "cat_shoes", price: nil, isFavorite: false),
        ItemModel(title: "Jeans", image: "cat_jeans", price: nil, isFavorite: false),
        ItemModel(title: "Accessories", image: "cat_accessories", price: nil, isFavorite: false),
    ]
    
    let sampleBrands: [ItemModel] = [
        ItemModel(title: "Nike", image: "", price: nil, isFavorite: false),
        ItemModel(title: "Carhartt", image: "", price: nil, isFavorite: false),
        ItemModel(title: "Champion", image: "", price: nil, isFavorite: false)
    ]
    
    let sampleShops: [ItemModel] = [
        ItemModel(title: "From Another", image: "shop1", price: nil, isFavorite: false),
        ItemModel(title: "Wild Rose", image: "shop2", price: nil, isFavorite: false),
        ItemModel(title: "More Than A Fad", image: "shop3", price: nil, isFavorite: false)
    ]

    func loadData() {
        isLoading = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.sections = self.mockSections()
            self.isLoading = false
        }
    }
}

extension DiscoverViewModel {
    func mockSections() -> [SectionModel] {
        return [
            SectionModel(
                title: "Recommended",
                type: .horizontalProducts,
                items: sampleProducts
            ),
            SectionModel(
                title: "Following",
                type: .horizontalProducts,
                items: sampleProducts
            ),
            SectionModel(
                title: "Popular Brands",
                type: .brands,
                items: sampleBrands
            ),
            SectionModel(
                title: "Shop Womenswear",
                type: .categoriesGrid,
                items: sampleCategories
            ),
            // Duplicate title again → WILL render again
            SectionModel(
                title: "Popular Brands",
                type: .brands,
                items: sampleBrands
            )
        ]
    }
}
