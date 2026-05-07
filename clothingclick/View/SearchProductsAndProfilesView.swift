//
//  SearchProductsAndProfilesView.swift
//  clothingclick
//
//  Created by DavidBisht on 29/04/26.
//

import SwiftUI

struct SearchProductsAndProfilesView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm = SearchProductsAndProfilesViewModel()
    @FocusState var searchFocusState: Bool
    private let profileColumns = [
        GridItem(.flexible())
    ]
    private let productColumns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                CustomTabBarView(
                    tabs: SearchProductsAndProfilesTabs.allCases,
                    selectedTab: vm.selectedTab,
                    title: { $0.rawValue }
                ) { tab in
                    vm.selectedTab = tab
                }
                searchAndFilterView
                    .padding()
                ScrollView {
                    VStack(spacing: 12) {
                        
                        
                        
                        LazyVGrid(
                            columns: vm.selectedTab == .products ? productColumns : profileColumns,
                            spacing: 16
                        ) {
                            switch vm.selectedTab {
                            case .products:
                                if vm.filteredProduct.isEmpty {
                                    Text("No results found")
                                        .foregroundColor(.gray)
                                        .padding(.top, 40)
                                } else {
                                    ForEach(vm.filteredProduct, id: \.id) { product in
                                        productCard(product)
                                    }
                                }
                            case .profiles:
                                if vm.filteredProfiles.isEmpty {
                                    Text("No results found")
                                        .foregroundColor(.gray)
                                        .padding(.top, 40)
                                } else {
                                    ForEach(vm.filteredProfiles, id: \.id) { profile in
                                        profileCard(profile)
                                        CustomDivider(color: AppColor.borderColor, lineWidth: 1)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .customNavigationBar(config: NavBarConfig(
                title: Constants.searchProductsAndProfiles,
                font: AppFont.medium.font(size: 15),
                leading:  NavBarItem(
                    title: "",
                    font: .system(size: 14),
                    image: "back",
                    isSystemImage: false,
                    tint: .black,
                    action: {
                        // dismiss
                        self.dismiss()
                    }
                )
            ))
            .toolbar(.hidden, for: .tabBar)
            .onAppear() {
                vm.mockData()
            }
        }
    }
    
    var searchAndFilterView: some View {
        HStack(spacing: 10) {
            Image(.search)

            TextField(Constants.searchWithDots, text: $vm.search)
                .font(AppFont.regular.font(size: 13))
                .foregroundStyle(AppColor.blackColor)
                .submitLabel(.search)
                .onSubmit {
                    vm.searchResult()
                }
                .onChange(of: vm.search) { _, _ in
                    vm.searchResult()
                }

            NavigationLink {
                FilterView()
            } label: {
                Image(.filter)
            }
            
        }
        .padding(12)
        .background(AppColor.lightGrayColor)
        .cornerRadius(10)
    }
    
    
    private func productCard(_ product: Product) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            
            AsyncImage(url: URL(string: product.image)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                AppColor.borderColor
            }
            .frame(height: 157)
            .frame(maxWidth: .infinity)
            .clipped()
            .border(AppColor.borderColor, width: 1)
            
            HStack {
                Text(product.name)
                    .font(AppFont.regular.font(size: 13))
                    .foregroundStyle(AppColor.blackColor)
                    .lineLimit(1)
                Spacer()
                Image(.heart)
            }

            Text("$\(product.price)")
                .font(AppFont.medium.font(size: 15))
                .foregroundStyle(AppColor.blackColor)

        }
        .padding(10)
    }
    
    private func profileCard(_ profile: User) -> some View {
        HStack(spacing: 8) {
            AsyncImage(url: URL(string: profile.image)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                AppColor.borderColor
            }
            .frame(width: 54, height: 54)
            .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(profile.name)
                    .font(AppFont.regular.font(size: 15))
                    .foregroundStyle(AppColor.blackColor)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(profile.username)
                    .font(AppFont.regular.font(size: 13))
                    .foregroundStyle(AppColor.darkGrayColor)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(0)
    }
    
}

#Preview {
    SearchProductsAndProfilesView()
}
