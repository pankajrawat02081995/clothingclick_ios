//
//  SearchProductsAndProfilesViewModel.swift
//  clothingclick
//
//  Created by DavidBisht on 29/04/26.
//

import Combine

enum SearchProductsAndProfilesTabs: String, CaseIterable {
    case products = "Products"
    case profiles = "Profiles"
}

class SearchProductsAndProfilesViewModel: ObservableObject {
    @Published var selectedTab: SearchProductsAndProfilesTabs = .products
    @Published var search = ""
    
    @Published var filteredProfiles: [User] = []
    @Published var filteredProduct: [Product] = []
    
    @Published var profiles: [User] = []
    @Published var product: [Product] = []
    
    func searchResult() {
        switch selectedTab {
        case .products:
            searchProduct()
            break;
        case .profiles:
            searchProfile()
            break;
        }
    }
    
    func searchProduct() {
        guard search.isEmpty == false else {
            filteredProduct = product
            return
        }
        filteredProduct = product.filter {
            $0.name.lowercased().contains(search.lowercased())
        }
    }
    
    func searchProfile() {
        guard search.isEmpty == false else {
            filteredProfiles = profiles
            return
        }
        filteredProfiles = profiles.filter {
            $0.name.lowercased().contains(search.lowercased())
        }
    }
}

extension SearchProductsAndProfilesViewModel {
    func mockData() {
        profiles = User.mockData
        product = Product.mockData
        
        filteredProduct = product
        filteredProfiles = profiles
    }
}
