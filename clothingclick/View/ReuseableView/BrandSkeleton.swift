//
//  BrandSkeleton.swift
//  clothingclick
//
//  Created by DavidBisht on 28/04/26.
//

import SwiftUI

struct BrandSkeleton: View {
    var body: some View {
        Circle()
            .fill(Color.gray.opacity(0.3))
            .frame(width: 80, height: 80)
            .overlay(
                ShimmerView()
                    .clipShape(Circle())
            )
    }
}

//#Preview {
//    BrandSkeleton()
//}
