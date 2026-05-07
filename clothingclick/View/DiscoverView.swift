//
//  DiscoverView.swift
//  clothingclick
//
//  Created by DavidBisht on 28/04/26.
//

import SwiftUI

struct DiscoverView: View {

    @StateObject private var vm = DiscoverViewModel()
    @State private var goToNotifications: Bool = false
    @State private var goToSelectLocation: Bool = false
    @State var location: String = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                searchAndFilterView
                if vm.isLoading {

                    // Skeleton follows SAME structure
                    ForEach(vm.sections.indices, id: \.self) { index in
                        SectionSkeletonView(type: vm.sections[index].type)
                    }

                    // If no sections yet → show default skeleton layout
                    if vm.sections.isEmpty {
                        defaultSkeleton
                    }

                } else {

                    ForEach(Array(vm.sections.enumerated()), id: \.offset) { _, section in
                        VStack {
                            HStack {
                                Text(section.title)
                                    .font(AppFont.medium.font(size: 20))
                                Spacer()
                                Button {
                                    print("See All")
                                } label: {
                                    Text(Constants.seeAll)
                                        .font(AppFont.medium.font(size: 10))
                                        .foregroundStyle(AppColor.blueColor)
                                }

                            }
                            .padding(.horizontal)
                            SectionView(section: section)
                        }
                    }
                    newSavedSearch
                    viewSavedSearches
                }
            }
        }
        .onAppear {
            if vm.isLoaded == false {
                vm.isLoaded = true
                vm.loadData()
            }
        }
        .navigationDestination(isPresented: $goToNotifications) {
            NotificationsView()
        }
        .navigationDestination(isPresented: $goToSelectLocation) {
            LocationView()
        }
        .customNavigationBar(
            config:NavBarConfig(
                title: Constants.AppName,
                font: AppFont.medium.font(size: 13.0),
                
                leading: NavBarItem(
                    title: location,
                    font: AppFont.medium.font(size: 13.0, relativeTo: .title),
                    image: "headerlocation",
                    isSystemImage: false,
                    action: { }
                ),
                
                trailing: [NavBarItem(
                    title: "",
                    font: AppFont.medium.font(size: 13.0, relativeTo: .title),
                    image: "bell",
                    isSystemImage: false,
                    action: {
                        goToNotifications = true
                    }
                )]
            )
        )
    }
    
    var defaultSkeleton: some View {
        VStack(spacing: 20) {
            SectionSkeletonView(type: .horizontalProducts)
            SectionSkeletonView(type: .categoriesGrid)
            SectionSkeletonView(type: .brands)
        }
    }
    
    var newSavedSearch: some View {
        NavigationLink {
            SavedSearchView()
        } label: {
            Text(Constants.createNewSavedSearch)
                .font(AppFont.medium.font(size: 15))
                .frame(maxWidth: .infinity)
                .padding()
                .background(AppColor.blackColor)
                .foregroundColor(AppColor.whiteColor)
                .cornerRadius(5)
                .padding(.horizontal)
        }
    }
    
    var viewSavedSearches: some View {
        NavigationLink {
            SavedSearchesView(vm: SavedSearchesViewModel())
        } label: {
            Text(Constants.viewSavedSearches)
                .font(AppFont.regular.font(size: 13))
                .frame(maxWidth: .infinity)
                .padding()
                .background(AppColor.whiteColor)
                .foregroundColor(AppColor.blackColor)
                .cornerRadius(5)
                .padding(.horizontal)
        }
    }
    
    var searchAndFilterView: some View {
        Group {
            HStack{
                NavigationLink {
                    SearchProductsAndProfilesView()
                } label: {
                    Image(.search)
                    Text(Constants.searchProductsAndProfiles)
                        .font(AppFont.regular.font(size: 13))
                        .foregroundStyle(AppColor.blackColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                NavigationLink {
                    FilterView()
                } label: {
                    Image(.filter)
                }
            }
            .padding(.horizontal)
            .padding(.vertical,10)
            .background(AppColor.lightGrayColor)
        }
        .padding(.horizontal)
    }
}

#Preview {
    DiscoverView()
}
