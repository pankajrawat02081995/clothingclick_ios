//
//  SubCategoryViewModel.swift
//  clothingclick
//
//  Created by DavidBisht on 01/05/26.
//

import Combine

class SubCategoryViewModel: ObservableObject {
    
    @Published var subCategoies: [SelectableItem] = []
    @Published var category: FilterItem
    
    init(category: FilterItem) {
        self.category = category
    }
    
    func getSubCategoies() {
        switch category.title {
        case Constants.tops:
            subCategoies = [
                SelectableItem(title: "All Tops"),
                SelectableItem(title: "Long Sleeves"),
                SelectableItem(title: "Sweaters"),
                SelectableItem(title: "Hoodies"),
                SelectableItem(title: "Dress Shirts"),
                SelectableItem(title: "Sport Jerseys")
            ]
        case Constants.bottoms:
            subCategoies = [
                SelectableItem(title: "All Bottoms"),
                SelectableItem(title: "Leggings"),
                SelectableItem(title: "Cargo Pants"),
                SelectableItem(title: "Dress Pants"),
                SelectableItem(title: "Sweat Pants"),
                SelectableItem(title: "Shorts"),
                SelectableItem(title: "Swim Shorts"),
                SelectableItem(title: "Skirts")
            ]
        default: break;
            subCategoies = []
        }
    }
    
}

