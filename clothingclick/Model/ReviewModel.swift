//
//  ReviewModel.swift
//  clothingclick
//
//  Created by DavidBisht on 12/05/26.
//

import Foundation

struct ReviewModel: Identifiable {

    let id = UUID()

    let userName: String
    let description: String
    let rating: Int
    let imageName: String
    let date: String
}
