//
//  Category.swift
//  clothingclick
//
//  Created by DavidBisht on 20/04/26.
//

import SwiftUI

struct Category: Identifiable, Codable {
    let id: Int
    let category: String
    let imageUrl: String
    let alt: String
    let range: [String]
}
