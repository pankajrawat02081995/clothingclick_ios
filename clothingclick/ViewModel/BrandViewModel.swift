//
//  BrandViewModel.swift
//  clothingclick
//
//  Created by DavidBisht on 01/05/26.
//

import Combine

class BrandViewModel: ObservableObject {
    @Published var search = ""
    
    @Published var brands: [Brand] = []
    @Published var filteredBrands: [Brand] = []
    
    func searchResult() {
        searchBrand()
    }
    
    func searchBrand() {
        guard search.isEmpty == false else {
            filteredBrands = brands
            return
        }
        filteredBrands = brands.filter {
            $0.name.lowercased().contains(search.lowercased())
        }
    }
    
}

extension BrandViewModel {
    func mockData() {
        brands =  [
            Brand(id: "1", brand: "Puma", image: "", name: "Puma", about: "test about"),
            Brand(id: "2", brand: "Nike", image: "", name: "Nike", about: "test about"),
            Brand(id: "3", brand: "Apple", image: "", name: "Apple", about: "test about"),
        ]
        
        filteredBrands = brands
    }
}
