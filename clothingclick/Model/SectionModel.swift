//
//  SectionModel.swift
//  clothingclick
//
//  Created by DavidBisht on 28/04/26.
//

import SwiftUI

struct SectionModel: Identifiable {
    let id = UUID()
    let title: String
    let type: SectionType
    let items: [ItemModel]
}

enum SectionType {
    case horizontalProducts
    case categoriesGrid
    case brands
    case localShops
}
