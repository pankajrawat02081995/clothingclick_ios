//
//  ProductGridView.swift
//  clothingclick
//
//  Created by DavidBisht on 26/04/26.
//

import SwiftUI

struct ProductGridView<Item: Identifiable, Content: View, Destination: View>: View {
    
    let title: String?
    let items: [Item]
    let columns: [GridItem]
    
    let content: (Item) -> Content
    let destination: ((Item) -> Destination)?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                // Title (optional)
                if let title = title {
                    Text(title)
                        .foregroundStyle(AppColor.blackColor)
                        .font(AppFont.regular.font(size: 17))
                }
                
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(items) { item in
                        
                        if let destination = destination {
                            NavigationLink(destination: destination(item)) {
                                content(item)
                            }
                        } else {
                            content(item)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ProductGridView(
        title: nil,
        items: [Product.sample],
        columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ],
        content: { product in
            ProductCardView(imageURL: product.image, title: product.name, price: "\(product.price)", isFavorite: product.isFavorite) {
            }
        },
        destination: { product in
            ProductDetailView(product: product)
        }
    )
}
