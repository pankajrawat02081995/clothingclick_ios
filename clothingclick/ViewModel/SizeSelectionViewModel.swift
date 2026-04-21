//
//  SizeSelectionViewModel.swift
//  clothingclick
//
//  Created by DavidBisht on 20/04/26.
//

import Combine

class SizeSelectionViewModel: ObservableObject {
    @Published var selectedTab: String
    @Published var categoryType: CategoryType
    @Published var categoriesFor: [String: [Category]] = [:]
    @Published var categories: [Category] = []
    @Published var selectedSizes: [String: [String: String]] = [:]
    
    init(selectedTab: String, categoryType: CategoryType) {
        self.selectedTab = selectedTab
        self.categoryType = categoryType
    }
    
    func fetchCategory() {
        categoriesFor.removeAll()
        // Menswear
        let mens: [Category] = [
            Category(id: 1, category: Constants.tops, imageUrl: "", alt: "mtops", range: ["XS","S","M","L","XL"]),
            Category(id: 2, category: Constants.bottoms, imageUrl: "", alt: "mjeans", range: ["28","30","32","34","36","38"]),
            Category(id: 3, category: Constants.footwear, imageUrl: "", alt: "mfootwear", range: ["7","8","9","10","11","12","6"]),
            Category(id: 4, category: Constants.outerwear, imageUrl: "", alt: "moutwear", range: ["S","M","L","XL"])
        ]
        
        // Womenswear
        let womens: [Category] = [
            Category(id: 5, category: Constants.tops, imageUrl: "", alt: "wtop", range: ["XXS","XS","S","M","L"]),
            Category(id: 6, category: Constants.bottoms, imageUrl: "", alt: "wjeans", range: ["26","28","30","32"]),
            Category(id: 7, category: Constants.footwear, imageUrl: "", alt: "wbottoms", range: ["XS","S","M","L"]),
            Category(id: 8, category: Constants.outerwear, imageUrl: "", alt: "wdress", range: ["XS","S","M","L"])
        ]
        
        // Assign properly
        switch categoryType {
        case .both:
            categoriesFor[Constants.menswear] = mens
            categoriesFor[Constants.womenswear] = womens
        case .menswear:
            categoriesFor[Constants.menswear] = mens
        case .womenswear:
            categoriesFor[Constants.womenswear] = womens
        }
        updateSelectedTab(selectedTab)
        
    }
    
    func selectSize(tab: String, category: String, size: String) {
        var tabSelection = selectedSizes[tab] ?? [:]
        tabSelection[category] = size
        selectedSizes[tab] = tabSelection
    }
    
    func selectedSize(tab: String, category: String) -> String? {
        return selectedSizes[tab]?[category]
    }
    
    func updateSelectedTab(_ identifier: String) {
        categories.removeAll()
        categories = categoriesFor[identifier] ?? []
        selectedTab = identifier
    }
    
}
