//
//  ProductCardView.swift
//  clothingclick
//
//  Created by DavidBisht on 27/04/26.
//

import SwiftUI

struct ProductCardView: View {
    
    let imageURL: String
    let title: String
    let price: String
    let isFavorite: Bool
    let onFavoriteTap: (() -> Void)?   // optional
    
    var body: some View {
        VStack(alignment: .leading) {
            
            // MARK: - Image
            AsyncImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(169.0 / 182.0, contentMode: .fit)
                    .clipped()
            } placeholder: {
                Image(systemName: "photo.on.rectangle.angled")
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(169.0 / 182.0, contentMode: .fit)
                    .clipped()
            }
            .overlay {
                RoundedRectangle(cornerRadius: 0)
                    .stroke(AppColor.borderColor, lineWidth: 1.0)
            }
            
            // MARK: - Title + Favorite
            HStack {
                Text(title)
                    .font(AppFont.regular.font(size: 13))
                    .foregroundStyle(AppColor.blackColor)
               
                Spacer()
                
                Image(isFavorite ? "heart.fill" : "heart")
                    .padding(.top, 5)
                    .onTapGesture {
                        onFavoriteTap?()
                    }
            }
            
            // MARK: - Price
            Text(price)
                .font(AppFont.medium.font(size: 15))
                .foregroundStyle(AppColor.blackColor)
        }
    }
}

//#Preview {
//    ProductCardView()
//}
