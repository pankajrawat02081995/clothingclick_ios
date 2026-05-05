//
//  SectionView.swift
//  clothingclick
//
//  Created by DavidBisht on 28/04/26.
//

import SwiftUI

struct SectionView: View {
    let section: SectionModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            switch section.type {

            case .horizontalProducts:
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(section.items) { item in
                            DiscoverProductCardView(item: item)
                        }
                    }
                    .padding(.horizontal)
                }

            case .categoriesGrid:
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3)) {
                    ForEach(section.items) { item in
                        CategoryItemView(item: item)
                    }
                }
                .padding(.horizontal)

            case .brands:
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(section.items) { item in
                            Image(item.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 97, height: 97)
                                .clipShape(Circle())
                                .overlay {
                                    Circle()
                                        .fill(AppColor.clearColor)
                                        .stroke(AppColor.borderColor, lineWidth: 1)
                                }
                        }
                    }
                    .padding(.horizontal)
                }

            case .localShops:
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(section.items) { item in
                            VStack(spacing: 10) {
                                Image(item.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 97, height: 97)
                                    .clipShape(Circle())
                                    .overlay {
                                        Circle()
                                            .fill(AppColor.clearColor)
                                            .stroke(AppColor.borderColor, lineWidth: 1)
                                    }

                                Text(item.title)
                                .font(AppFont.medium.font(size: 15))                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

//#Preview {
//    SectionView()
//}
