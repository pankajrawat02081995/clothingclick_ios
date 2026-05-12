//
//  DiscoverProductCardView.swift
//  clothingclick
//
//  Created by DavidBisht on 28/04/26.
//

import SwiftUI

struct DiscoverProductCardView: View {
    let item: ItemModel

    var body: some View {
        VStack(alignment: .leading) {
            
            // MARK: - Image
            AsyncImage(url: URL(string: item.image)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 144, height: 157)
//                    .aspectRatio(169.0 / 182.0, contentMode: .fit)
                    .clipped()
            } placeholder: {
                Image(systemName: "photo.on.rectangle.angled")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 144, height: 157)
//                    .aspectRatio(169.0 / 182.0, contentMode: .fit)
                    .clipped()
            }
            .border(AppColor.borderColor, width: 1)
            
            // MARK: - Title + Favorite
            HStack {
                Text(item.title)
                    .font(AppFont.regular.font(size: 13))
                    .foregroundStyle(AppColor.blackColor)
               
                Spacer()
                if item.isFavorite != nil {
                    Image((item.isFavorite!) ? "heart.fill" : "heart")
                        .padding(.top, 5)
                        .onTapGesture {
//                            onFavoriteTap?()
                        }
                }
            }
            
            // MARK: - Price
            Text("\(item.price ?? "")")
                .font(AppFont.medium.font(size: 15))
                .foregroundStyle(AppColor.blackColor)
        }
    }
//    {
//        VStack(alignment: .leading) {
//            Image(item.image)
//                .resizable()
//                .scaledToFill()
//                .frame(width: 140, height: 160)
//                .clipped()
//                .cornerRadius(5)
//
//            Text(item.title)
//                .font(.subheadline)
//
//            if let price = item.price {
//                Text(price)
//                    .font(.headline)
//            }
//        }
//        .frame(width: 140)
//    }
}

#Preview {
    DiscoverProductCardView(item: ItemModel(title: "Dress Shirt", image: "shirt1", price: "$140", isFavorite: false))
}

