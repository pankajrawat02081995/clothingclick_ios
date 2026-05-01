//
//  ItemModel.swift
//  clothingclick
//
//  Created by DavidBisht on 28/04/26.
//

import SwiftUI

struct ItemModel: Identifiable {
    let id = UUID()
    let title: String
    let image: String
    let price: String?
    let isFavorite: Bool?
}
