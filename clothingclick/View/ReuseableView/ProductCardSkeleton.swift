//
//  ProductCardSkeleton.swift
//  clothingclick
//
//  Created by DavidBisht on 28/04/26.
//

import SwiftUI

struct ProductCardSkeleton: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 140, height: 160)
                .overlay(
                    ShimmerView()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                )

            RoundedRectangle(cornerRadius: 4)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 100, height: 10)
                .overlay(
                    ShimmerView()
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                )

            RoundedRectangle(cornerRadius: 4)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 60, height: 10)
                .overlay(
                    ShimmerView()
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                )
        }
        .frame(width: 140)
    }
}

#Preview {
    ProductCardSkeleton()
}
