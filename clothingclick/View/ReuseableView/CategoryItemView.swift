//
//  CategoryItemView.swift
//  clothingclick
//
//  Created by DavidBisht on 28/04/26.
//

import SwiftUI

struct CategoryItemView: View {
    let item: ItemModel

    var body: some View {
        VStack(spacing:10) {
            Image(item.image)
                .resizable()
                .scaledToFit()
                .frame(width: 103, height: 103)
                .clipped()
                .border(AppColor.borderColor, width: 1)

            Text(item.title)
                .font(AppFont.medium.font(size: 15))
        }
    }
}

#Preview {
    CategoryItemView(item: ItemModel(title: "Cap", image: "",price: "34",isFavorite: false))
}
