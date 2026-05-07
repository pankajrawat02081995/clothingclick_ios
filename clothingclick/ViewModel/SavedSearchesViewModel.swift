//
//  SavedSearchesViewModel.swift
//  clothingclick
//
//  Created by DavidBisht on 05/05/26.
//

import Combine

class SavedSearchesViewModel: ObservableObject {
    @Published var savedSearches: [SavedSearch] = []
}

extension SavedSearchesViewModel {
    func mockData() {
        savedSearches = [
            SavedSearch(title: "Search List Name", itemsCount: 3213),
            SavedSearch(title: "Test Name", itemsCount: 32),
            SavedSearch(title: "Name", itemsCount: 314)
        ]
    }
}
