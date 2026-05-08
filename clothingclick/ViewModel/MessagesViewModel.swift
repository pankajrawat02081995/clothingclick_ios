//
//  MessagesViewModel.swift
//  clothingclick
//
//  Created by DavidBisht on 07/05/26.
//

import Combine

enum MessagesViewTabs: String, CaseIterable {
    case buying = "Buying"
    case selling = "Selling"
}

class MessagesViewModel: ObservableObject {
    @Published var selectedTab: MessagesViewTabs = .buying
    @Published var search = ""
    
    @Published var filteredBuyingProfiles: [User] = []
    @Published var filteredSellingProfiles: [User] = []
    
    @Published var buyingProfiles: [User] = []
    @Published var sellingProfiles: [User] = []
    
    func searchResult() {
        switch selectedTab {
        case .buying:
            searchBuyingProfiles()
            break;
        case .selling:
            searchSellingProfile()
            break;
        }
    }
    
    func searchBuyingProfiles() {
        guard search.isEmpty == false else {
            filteredBuyingProfiles = buyingProfiles
            return
        }
        filteredBuyingProfiles = buyingProfiles.filter {
            $0.name.lowercased().contains(search.lowercased())
        }
    }
    
    func searchSellingProfile() {
        guard search.isEmpty == false else {
            filteredSellingProfiles = sellingProfiles
            return
        }
        filteredSellingProfiles = sellingProfiles.filter {
            $0.name.lowercased().contains(search.lowercased())
        }
    }
}

extension MessagesViewModel {
    func mockData() {
        buyingProfiles = User.mockData
        sellingProfiles = User.mockData
        sellingProfiles.removeLast(2)
        
        filteredBuyingProfiles = buyingProfiles
        filteredSellingProfiles = sellingProfiles
    }
}
