//
//  ReviewCardView.swift
//  clothingclick
//
//  Created by DavidBisht on 27/04/26.
//

import SwiftUI

struct ReviewCardView: View {
    let review: Review
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading, spacing: 6) {
                StarRatingView(rating: review.rating)
                    .padding(.bottom, 10)
                Text(review.username)
                    .font(AppFont.medium.font(size: 15))
                    .foregroundStyle(AppColor.blackColor)
                
                Text(review.comment)
                    .font(AppFont.regular.font(size: 13))
                    .foregroundStyle(AppColor.grayTextColor)
                    .lineLimit(.max)
                
                Text(review.date)
                    .font(AppFont.regular.font(size: 13))
                    .foregroundStyle(AppColor.blackColor)

            }
            
            Spacer()
            
            Image(review.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 54, height: 54)
                .background(AppColor.borderColor)
        }
        .padding(0)
        .background(AppColor.whiteColor)
        .cornerRadius(0)
    }
}

#Preview {
    ReviewCardView(review: Review.init(username: "Darshan", rating: 5, comment: "Great!", imageName: "", date: "22-3-26"))
}
