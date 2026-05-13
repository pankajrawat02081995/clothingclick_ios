//
//  ReviewListView.swift
//  clothingclick
//
//  Created by DavidBisht on 12/05/26.
//

import SwiftUI

struct ReviewListView: View {

    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = ReviewListViewModel()

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 0) {
                    shareYourExperienceSection
                    LazyVStack(spacing: 0) {
                        
                        ForEach(viewModel.reviews) { review in
                            
                            ReviewCardView(review: review)
                                .padding()
                            Divider()
                        }
                    }
                }
            }
        }
        .customNavigationBar(
            config:NavBarConfig(
                title: Constants.rateFromAnother,
                font: AppFont.medium.font(size: 13.0),
                
                leading: NavBarItem(
                    title: "",
                    font: AppFont.medium.font(size: 13.0, relativeTo: .title),
                    image: "back",
                    isSystemImage: false,
                    action: {
                        print("back tapped")
                        dismiss()
                    }
                )
            )
        )
    }
    
    private var shareYourExperienceSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(Constants.shareYourExperience)
                .font(AppFont.semibold.font(size: 13))
                .foregroundColor(AppColor.blackColor)
            Text(Constants.pleaseShareDetailsOfYourOwnExperienceAtThisStore)
                .font(AppFont.regular.font(size: 11))
                .foregroundColor(AppColor.blackColor)
            Button {
                
            } label: {
                Text(Constants.leaveAReview)
                    .font(AppFont.medium.font(size: 15))
                    .foregroundColor(AppColor.whiteColor)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(AppColor.blackColor)
                    .cornerRadius(5)
            }
        }
        .padding()
        .background(AppColor.lightGrayColor)
        .cornerRadius(5)
        .padding()
    }
}

#Preview {
    ReviewListView()
}
