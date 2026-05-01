//
//  CategorySkeleton.swift
//  clothingclick
//
//  Created by DavidBisht on 28/04/26.
//

import SwiftUI

struct CategorySkeleton: View {
    var body: some View {
        VStack(spacing: 8) {

            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.3))
                .frame(height: 100)
                .overlay(
                    ShimmerView()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                )

            RoundedRectangle(cornerRadius: 4)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 60, height: 10)
                .overlay(
                    ShimmerView()
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                )
        }
    }
}

#Preview {
    CategorySkeleton()
}
