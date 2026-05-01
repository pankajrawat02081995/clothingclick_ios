//
//  BrandView.swift
//  clothingclick
//
//  Created by DavidBisht on 01/05/26.
//

import SwiftUI

struct BrandView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm = BrandViewModel()
    @FocusState private var isFocused: Bool

    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                searchView
                    .padding()
                Text(Constants.popularBrand)
                    .font(AppFont.medium.font(size: 20))
                    .foregroundStyle(AppColor.blackColor)
                    .padding(.horizontal)
                List(vm.filteredBrands) {
                    BrandCardView(brand: $0) { selectedBrand in
                        print("Tapped:", selectedBrand.name)
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(.zero))
                }
                .listStyle(.plain)
                
            }
            .onAppear() {
                vm.mockData()
            }
        }
        .customNavigationBar(
            config:
                NavBarConfig(
                    title: Constants.brand,
                    font: AppFont.medium.font(size: 15.0),
                    leading: NavBarItem(
                        title: "",
                        font: AppFont.medium.font(size: 13.0, relativeTo: .title),
                        image: "back",
                        isSystemImage: false,
                        tint: AppColor.blackColor,
                        action: {
                            dismiss()
                        }
                    )
                )
        )
    }
    
    var searchView: some View {
        HStack(spacing: 10) {
            TextField(
                "",
                text: $vm.search,
                prompt:
                    Text(Constants.searchDesignersAndBrandNames)
                    .font(AppFont.regular.font(size: 13))
                    .foregroundColor(AppColor.blackColor)
            )
            .font(AppFont.regular.font(size: 13))
            .foregroundStyle(AppColor.blackColor)
            .focused($isFocused)
            .submitLabel(.search)
            .onSubmit {
                vm.searchResult()
            }
            .onChange(of: vm.search) { _, _ in
                vm.searchResult()
            }
            Image(.search)
                .onTapGesture {
                    isFocused = true
                }
        }
        .padding(12)
        .background(AppColor.lightGrayColor)
        .cornerRadius(10)
    }
}

#Preview {
    BrandView()
}
