//
//  Review.swift
//  clothingclick
//
//  Created by DavidBisht on 27/04/26.
//

import Foundation

struct Review: Identifiable {
    let id = UUID()
    let username: String
    let rating: CGFloat
    let comment: String
    let imageName: String
    let date: String
}
