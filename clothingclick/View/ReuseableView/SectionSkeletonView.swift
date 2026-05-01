//
//  SectionSkeletonView.swift
//  clothingclick
//
//  Created by DavidBisht on 28/04/26.
//

import SwiftUI

struct SectionSkeletonView: View {
    let type: SectionType

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            // Header
//            SectionHeaderSkeleton()

            switch type {

            case .horizontalProducts:
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(0..<5, id: \.self) { _ in
                            ProductCardSkeleton()
                        }
                    }
                    .padding(.horizontal)
                }

            case .categoriesGrid:
                LazyVGrid(
                    columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 3),
                    spacing: 12
                ) {
                    ForEach(0..<6, id: \.self) { _ in
                        CategorySkeleton()
                    }
                }
                .padding(.horizontal)

            case .brands:
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(0..<5, id: \.self) { _ in
                            BrandSkeleton()
                        }
                    }
                    .padding(.horizontal)
                }

            case .localShops:
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(0..<5, id: \.self) { _ in
                            VStack(spacing: 8) {
                                BrandSkeleton()

                                ShimmerView()
                                    .frame(width: 60, height: 10)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    SectionSkeletonView(type: .brands)
}
