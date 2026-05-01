//
//  FilterViewModel.swift
//  clothingclick
//
//  Created by DavidBisht on 01/05/26.
//

import Combine

final class FilterViewModel: ObservableObject {
    
    @Published var items: [FilterItem]
    @Published var resultCount: Int = 4532
    @Published var route: FilterRoute?
    
    init(items: [FilterItem]) {
        self.items = items
    }
    
    func toggle(_ key: FilterKey, value: Bool) {
        guard let index = items.firstIndex(where: { $0.key == key }) else { return }
        items[index].type = .toggle(isOn: value)
    }
    
    func select(_ key: FilterKey) {
        switch key {
        case .department: route = .department
        case .category: route = .category
        case .size: route = .size
        case .style: route = .style
        case .brandName: route = .brandName
        case .color: route = .color
        case .condition: route = .condition
        case .seller: route = .seller
        case .price: route = .price
        case .distance: route = .distance
        case .sort: route = .sort
        case .mySizes: break // toggle, no navigation
        }
    }
    
    func clearAll() {
        for index in items.indices {
            switch items[index].type {
            case .toggle:
                items[index].type = .toggle(isOn: false)
            case .navigation:
                items[index].type = .navigation(value: nil)
            }
        }
    }
    
    func apply() {
        print("Apply filters")
    }
}
