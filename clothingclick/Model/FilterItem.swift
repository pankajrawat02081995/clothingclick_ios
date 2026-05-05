//
//  FilterItem.swift
//  clothingclick
//
//  Created by DavidBisht on 30/04/26.
//

import SwiftUI

struct FilterItem: Identifiable {
    let id = UUID()
    let title: String
    var type: FilterRowType
    var key: FilterKey
}

enum FilterRowType {
    case toggle(isOn: Bool)
    case navigation(value: String?)
}

enum FilterKey: String, Hashable {
    case mySizes = "My Sizes"
    case department = "Department"
    case category = "Category"
    case size = "Size"
    case style = "Style"
    case brandName = "Brand Name"
    case color = "Color"
    case condition = "Condition"
    case seller = "Seller"
    case price = "Price"
    case distance = "Distance"
    case sort = "sort"
    case subCategory = "subCategory"
}

enum FilterRoute: Hashable {
    case department
    case category
    case size
    case style
    case brandName
    case color
    case condition
    case seller
    case price
    case distance
    case sort
    case subCategory
}
