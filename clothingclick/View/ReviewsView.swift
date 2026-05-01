//
//  ReviewsView.swift
//  clothingclick
//
//  Created by DavidBisht on 27/04/26.
//

import SwiftUI

struct ReviewsView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm = ReviewsViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            //Tab
            CustomTabBarView(
                tabs: ReviewTab.allCases,
                selectedTab: vm.selectedTab,
                title: { $0.rawValue + "(236)"}
            ) { tab in
                vm.selectedTab = tab
            }
            // List
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(vm.reviews) { review in
                        ReviewCardView(review: review)
                            .padding(.horizontal)
                        Divider()
                    }
                }
                .padding(.vertical)
            }
            
        }
        .customNavigationBar(
            config:NavBarConfig(
                title: "Aman",
                font: AppFont.medium.font(size: 13.0),
                
                leading: NavBarItem(
                    title: "",
                    font: AppFont.medium.font(size: 13.0, relativeTo: .title),
                    image: "back",
                    isSystemImage: false,
                    action: {
                        print("back tapped")
                        self.dismiss()
                    }
                ),
                
                trailing: [NavBarItem(
                    title: "",
                    font: AppFont.medium.font(size: 13.0, relativeTo: .title),
                    image: "threedots",
                    isSystemImage: false,
                    action: {
                        print("dots tapped")
                    }
                )]
            )
        )
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    ReviewsView()
}
