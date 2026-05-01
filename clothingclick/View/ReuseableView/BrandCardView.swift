//
//  BrandCardView.swift
//  clothingclick
//
//  Created by DavidBisht on 01/05/26.
//

import SwiftUI

struct BrandCardView: View {
    
    let brand: Brand
    var onTap: ((Brand) -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 8) {
                AsyncImage(url: URL(string: brand.image)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    AppColor.borderColor
                }
                .frame(width: 69, height: 69)
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(AppColor.borderColor, lineWidth: 1)
                }
                VStack(alignment: .leading) {
                    Text(brand.name)
                        .font(AppFont.regular.font(size: 17))
                        .foregroundStyle(AppColor.blackColor)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(brand.about)
                        .font(AppFont.regular.font(size: 13))
                        .foregroundStyle(AppColor.darkGrayColor)
                        .lineLimit(1)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            CustomDivider(color: AppColor.borderColor, lineWidth: 1)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onTap?(brand)
        }
    }
}

//#Preview {
//    BrandCardView()
//}
