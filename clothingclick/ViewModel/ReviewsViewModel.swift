//
//  ReviewsViewModel.swift
//  clothingclick
//
//  Created by DavidBisht on 27/04/26.
//

import Combine
import Foundation

class ReviewsViewModel: ObservableObject {
    @Published var selectedTab: ReviewTab = .purchased
    @Published var reviews: [Review] = []
    
    init() {
        loadMockData()
    }
    
    func loadMockData() {
        reviews = [
            Review(username: "Abram Rosser",
                   rating: 4.5,
                   comment: "Auctor quis sagittis sit ac et praesent nulla malesuada",
                   imageName: "shirt",
                   date: "2 days ago"),
            
            Review(username: "Abram Rosser",
                   rating: 4.2,
                   comment: "Purus ornare eget quisque tellus dui a eu",
                   imageName: "pants",
                   date: "2 days ago"),
            
            Review(username: "Abram Rosser",
                   rating: 3.8,
                   comment: "Vehicula elit massa nibh a at",
                   imageName: "jacket",
                   date: "2 days ago")
        ]
    }
}

enum ReviewTab: String, CaseIterable {
    case sold = "Sold"
    case purchased = "Purchased"
}
