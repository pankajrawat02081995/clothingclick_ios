//
//  SavedSearchViewModel.swift
//  clothingclick
//
//  Created by DavidBisht on 06/05/26.
//

import Combine

class SavedSearchViewModel: ObservableObject {
    @Published var filterViewModel = FilterViewModel(items: [
        FilterItem(title: "My Sizes", type: .toggle(isOn: true), key: .mySizes),
        FilterItem(title: "Department", type: .navigation(value: "Menswear"), key: .department),
        FilterItem(title: "Category", type: .navigation(value: nil), key: .category),
        FilterItem(title: "Size", type: .navigation(value: "S,S,28,M,S"), key: .size),
        FilterItem(title: "Style", type: .navigation(value: nil), key: .style),
        FilterItem(title: "Brand Name", type: .navigation(value: nil), key: .brandName),
        FilterItem(title: "Color", type: .navigation(value: nil), key: .color),
        FilterItem(title: "Condition", type: .navigation(value: nil), key: .condition),
        FilterItem(title: "Seller", type: .navigation(value: nil), key: .seller),
        FilterItem(title: "Price", type: .navigation(value: nil), key: .price),
        FilterItem(title: "Distance", type: .navigation(value: nil), key: .distance),
    ])
    @Published var searchTitle: String = ""
    @Published var itemCount: String = "1"
}
