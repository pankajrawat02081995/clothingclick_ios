//
//  DiscoverView.swift
//  clothingclick
//
//  Created by DavidBisht on 28/04/26.
//

import SwiftUI

struct DiscoverView: View {

    @StateObject private var vm = DiscoverViewModel()

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
                }
            }
        }
        .onAppear {
            if vm.isLoaded == false {
                vm.isLoaded = true
                vm.loadData()
            }
        }
    }
    
    var defaultSkeleton: some View {
        VStack(spacing: 20) {
            SectionSkeletonView(type: .horizontalProducts)
            SectionSkeletonView(type: .categoriesGrid)
            SectionSkeletonView(type: .brands)
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
