//
//  StarRatingView.swift
//  clothingclick
//
//  Created by DavidBisht on 27/04/26.
//

import SwiftUI

struct StarRatingView: View {
    let rating: CGFloat
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<5) { index in
                starType(for: index)
            }
        }
    }
    
    @ViewBuilder
        private func starType(for index: Int) -> some View {
            let value = Double(index)
            
            if rating >= value + 1 {
                Image("ratingStar") // full star
            } else if rating > value { // star base on percentage
                GeometryReader { geo in
                    let fillPercentage: CGFloat = (rating - value)
                    let emptyPercentage: CGFloat = (1 - fillPercentage)
                    ZStack {
                        Image("ratingStar")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width, height: geo.size.height)
                            .clipped()
                            .mask(
                                Rectangle()
                                    .frame(width: geo.size.width * fillPercentage)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            )
                        Image("ratingStar")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFill()
                            .foregroundStyle(AppColor.borderColor)
                            .frame(width: geo.size.width, height: geo.size.height)
                            .clipped()
                            .mask(
                                Rectangle()
                                    .frame(width: geo.size.width * emptyPercentage)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            )
                    }
                }
                .frame(width: 24, height: 24)
            } else {
                Image("ratingStar") // empty star
                    .renderingMode(.template)
                    .foregroundStyle(AppColor.borderColor)
            }
        }
}
