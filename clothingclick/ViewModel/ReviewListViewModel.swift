//
//  ReviewListViewModel.swift
//  clothingclick
//
//  Created by DavidBisht on 12/05/26.
//

import Foundation
import Combine

final class ReviewListViewModel: ObservableObject {

    @Published var reviews: [Review] = [

        Review(
            username: "Abram Rosser",
            rating: 5,
            comment: "Auctor quis sagittis sit ac et praesent nulla malesuada. Purus ornare eget quisque tellus dui a eu. Enim tincidunt sagittis hac tincidunt.",
            imageName: "shirt1",
            date: "2 days ago"
        ),

        Review(
            username: "Abram Rosser",
            rating: 5,
            comment: "Vehicula elit massa nibh a at. Interdum lacinia eu sem malesuada.",
            imageName: "shirt2",
            date: "2 days ago"
        ),

        Review(
            username: "Abram Rosser",
            rating: 5,
            comment: "Interdum lacinia eu sem malesuada.",
            imageName: "shirt3",
            date: "2 days ago"
        )
    ]
    
}
