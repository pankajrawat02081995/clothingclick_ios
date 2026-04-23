//
//  Product.swift
//  clothingclick
//
//  Created by DavidBisht on 22/04/26.
//

import SwiftUI

struct Product: Identifiable {
    let id = UUID()
    let name: String
    let price: Int
    let image: String
    let size: String
    let condition: String
    let location: String
    let description: String
    let sellerName: String
    let sellerImage: String
}

extension Product {
    
    static let sample = Product(
        name: "White Tshirt",
        price: 40,
        image: "https://tse2.mm.bing.net/th/id/OIP.rnvQIFY2RGAq_0-jYFNwPAHaHa?pid=Api&h=220&P=0",
        size: "XXL",
        condition: "New",
        location: "Edmonton",
        description: "Auctor quis sagittis sit ac et praesent nulla malesuada. Purus ornare eget quisque tellus dui a eu. Enim tincidunt sagittis hac tincidunt. Vehicula elit massa nibh a at. Interdum lacinia eu sem malesuada. Vitae consectetur porttitor enim feugiat. Euismod pulvinar amet scelerisque augue nibh. Viverra dui vitae aenean a blandit id. Suspendisse placerat lectus tempus sed mauris magna cursus feugiat egestas. Elit sapien venenatis dictum aliquet nunc cursus auctor. Risus vitae lectus convallis amet facilisi vulputate sed massa. Porttitor arcu fermentum.",
        sellerName: "Jessica Milan",
        sellerImage: "p2"
    )
    
    static let mockData = [
        Product.sample,
        Product.sample,
        Product.sample
    ]
}
