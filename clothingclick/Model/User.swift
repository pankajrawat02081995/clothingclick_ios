//
//  User.swift
//  clothingclick
//
//  Created by DavidBisht on 26/04/26.
//

import Foundation

struct User: Identifiable {
    let id = UUID()
    let name: String
    let username: String
    let followers: Int
    var isFollowing: Bool
    let image: String
}
