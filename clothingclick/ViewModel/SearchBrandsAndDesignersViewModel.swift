//
//  SearchBrandsAndDesignersViewModel.swift
//  clothingclick
//
//  Created by DavidBisht on 11/05/26.
//

import Combine

class SearchBrandsAndDesignersViewModel: ObservableObject {
    @Published var searchResults: [String] = []
    @Published var search: String = ""
    @Published var selectedItem: String = ""
    
    func searchResult() {
        guard search.isEmpty == false else {
            searchResults = []
            return
        }
        searchResults = ["demo data", "damo data 2"]
    }
    
}
