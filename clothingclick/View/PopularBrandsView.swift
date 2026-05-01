//
//  PopularBrandsView.swift
//  clothingclick
//
//  Created by DavidBisht on 29/04/26.
//

import SwiftUI

struct PopularBrandsView: View {
    @Environment(\.dismiss) var dismiss
    @State var title: String
    var brands: [Brand] = [
        Brand(id: "1", brand: "Puma", image: "", name: "Puma", about: "test about"),
        Brand(id: "2", brand: "Nike", image: "", name: "Nike", about: "test about"),
        Brand(id: "3", brand: "Apple", image: "Apple", name: "Apple", about: "test about"),
    ]
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("Popular Brands Listing")
                    .font(AppFont.medium.font(size: 20))
                    .foregroundStyle(AppColor.blackColor)
                    .padding(.horizontal)
                List(brands) {
                    BrandCardView(brand: $0) { selectedBrand in
                        print("Tapped:", selectedBrand.name)
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                .listStyle(.plain)
                
            }
            .customNavigationBar(
                config:
                    NavBarConfig(
                        title: title,
                        font: AppFont.medium.font(size: 15.0),
                        leading: NavBarItem(
                            title: "",
                            font: AppFont.medium.font(size: 13.0, relativeTo: .title),
                            image: "back",
                            isSystemImage: false,
                            tint: AppColor.blackColor,
                            action: {
                                self.dismiss()
                            }
                        )
                    )
            )
        }
    }
    
}

#Preview {
    PopularBrandsView(title: "Brands")
}
