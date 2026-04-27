//
//  SizeSelectionView.swift
//  clothingclick
//
//  Created by DavidBisht on 20/04/26.
//

import SwiftUI

struct SizeSelectionView: View {
    var category: String
    @State private var showLocationPermission = false
    @StateObject var vm: SizeSelectionViewModel
    @Environment(\.dismiss) var dismiss
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ScrollView {
                if vm.categoriesFor.count == 1 {
                    if let first = vm.categoriesFor.first {
                        let key = first.key
                        VStack(spacing: 6) {
                            Text(key)
                                .font(AppFont.regular.font(size: 15.0))
                                .foregroundColor(AppColor.blackColor)
                                .frame(maxWidth: .infinity)
                            Rectangle()
                                .fill(AppColor.clearColor)
                                .frame(height: 1)
                        }
                        .contentShape(Rectangle())
                    }
                    Divider()
                } else {
                    let tabs = vm.categoriesFor.keys.sorted()
                    selectCategoryToExplore(tabs)
                }
            }
            .frame(height: 44)
            .padding(0)
            ScrollView {
                VStack(alignment: .leading,spacing: 20.0) {
                    ForEach(vm.categories) { category in
                        sizeCategory(title: category.category, sizes: category.range, alt: category.alt)
                            .padding(0)
                    }
                }
                .padding(0)
            }
            .padding(.horizontal)
            .onAppear() {
                Task {
                    vm.fetchCategory()
                }
            }

            Spacer()
            
            if locationManager.isAuthorized {
                NavigationLink(destination: MainTabView()) {
                    VStack {
                        Text(Constants.next)
                            .font(AppFont.medium.font(size: 15.0))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(AppColor.blackColor)
                            .foregroundColor(AppColor.whiteColor)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                }
            } else {
                Button(action: {
                    showLocationPermission = true
                }) {
                    Text(Constants.next)
                        .font(AppFont.medium.font(size: 15.0))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(AppColor.blackColor)
                        .foregroundColor(AppColor.whiteColor)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
            }
        }
        .overlay(content: {
            if showLocationPermission == true {
                LocationPermissionView(showPopup: $showLocationPermission)
            }
        })
        .customNavigationBar(
            config: NavBarConfig(
                title: Constants.selectSizes,
                font: AppFont.medium.font(size: 13.0, relativeTo: .title),
                
                leading: NavBarItem(
                    title: "",
                    font: AppFont.medium.font(size: 13.0, relativeTo: .title),
                    image: "back",
                    isSystemImage: false,
                    action: {
                        print("Back tapped")
                        self.dismiss()
                    }
                ),
                
                trailing: [NavBarItem(
                    title: "Skip",
                    font: AppFont.medium.font(size: 13.0, relativeTo: .title),
                    image: "",
                    isSystemImage: false,
                    tint: AppColor.borderColor,
                    action: {
                        print("Skip tapped")
                    }
                ),]
            )
        )
        .padding(0)
    }
    
    private func selectCategoryToExplore(_ tabs: [String]) -> some View {
        VStack(spacing: 0) {
            
            HStack(spacing: 0) {
                ForEach(tabs, id: \.self) { tab in
                    
                    VStack(spacing: 6) {
                        
                        // Title
                        Text(tab)
                            .font(AppFont.regular.font(size: 15.0))
                            .foregroundColor(vm.selectedTab == tab ? AppColor.blackColor : AppColor.darkGrayColor)
                            .frame(maxWidth: .infinity)
                        
                        // Underline
                        Rectangle()
                            .fill(vm.selectedTab == tab ? AppColor.blackColor : AppColor.clearColor)
                            .frame(height: 1)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            vm.updateSelectedTab(tab)
                        }
                    }
                }
            }
            
            Divider()
        }
        .padding(0)
    }
    
    private func subTitleView(subTitle: String) -> some View {
        Text(Constants.selectSizes)
            .foregroundStyle(AppColor.blackColor)
            .font(AppFont.medium.font(size: 13.0))
    }

    private func sizeCategory(title: String, sizes: [String], alt: String) -> some View {
        SizeCategoryView(
            title: title,
            titleFont: nil,
            sizes: sizes,
            icon: alt,
            isSystemImage: false,
            selectedSize: vm.selectedSize(tab: vm.selectedTab, category: title),
            strokeColors: nil
        ) { size in
            vm.selectSize(tab: vm.selectedTab, category: title, size: size)
        }
    }
}
