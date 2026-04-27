//
//  ProfileViewModel.swift
//  clothingclick
//
//  Created by DavidBisht on 26/04/26.
//

import SwiftUI
import Combine

class ProfileViewModel: ObservableObject {
    
    @Published var user = User(
        name: "Jayden",
        username: "@Jayden03",
        followers: 213,
        isFollowing: true,
        image: "profile"
    )
    
    @Published var products: [Product] = Product.mockData
    @Published var isFollowing: Bool = false
}
