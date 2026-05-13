//
//  AccountViewModel.swift
//  clothingclick
//
//  Created by DavidBisht on 12/05/26.
//

import Combine

class AccountViewModel: ObservableObject {
    
    @Published var user = User(
        name: "Jayden",
        username: "@Jayden03",
        followers: 213,
        isFollowing: true,
        image: "profile"
    )
    
    let tabs: [String] = ["Selling","Sold"]
    @Published var selectedTab: String = "Selling"
    
    @Published var products: [Product] = Product.mockData
    @Published var isFacebookLinked: Bool = false
    @Published var isInstagramLinked: Bool = false
    
    func toggleFavorite(_ product:Product) {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            products[index].isFavorite = !product.isFavorite
        }
    }
}
