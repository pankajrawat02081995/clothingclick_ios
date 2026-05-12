//
//  LandingPageView.swift
//  clothingclick
//
//  Created by DavidBisht on 20/04/26.
//

import SwiftUI

struct LandingPageView: View {

    var body: some View {
        NavigationStack {
            ZStack {
                Image(.landingModel)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                Color(.clear)
                    .background(LinearGradient(
                        colors: [.clear,.clear,.black],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                VStack(alignment: .leading, spacing: 15) {
                   
                    Spacer()
                    VStack(alignment: .leading, spacing: 8.0) {
                        Text(Constants.landingViewTitle)
                            .font(AppFont.semibold.font(size: 20, relativeTo: .title2))
                            .foregroundStyle(AppColor.whiteColor)
                            .padding(.horizontal, 20)
                        Text(Constants.landingViewSubTitle)
                            .font(AppFont.light.font(size: 15, relativeTo: .title2))
                            .foregroundStyle(AppColor.whiteColor)
                            .padding(.horizontal, 20)
                        
                    }
                    VStack(spacing: 10) {
                        NavigationLink(destination: SizeSelectionView(category: Constants.menswear, vm: SizeSelectionViewModel(selectedTab: Constants.womenswear, categoryType: .womenswear))) {
                            selectionButton(title: Constants.menswear.uppercased())
                        }
                        
                        NavigationLink(destination: SizeSelectionView(category: Constants.womenswear, vm: SizeSelectionViewModel(selectedTab: Constants.womenswear, categoryType: .womenswear))) {
                            selectionButton(title: Constants.womenswear.uppercased())
                        }
                        
                        NavigationLink(destination: SizeSelectionView(category: Constants.both, vm: SizeSelectionViewModel(selectedTab: Constants.menswear, categoryType: .both))) {
                            selectionButton(title: Constants.both.uppercased())
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                }
                .padding()
            }
        }
    }

    private func selectionButton(title: String) -> some View {
        Text(title)
            .font(AppFont.medium.font(size: 15, relativeTo: .title2))
            .frame(maxWidth: .infinity)
            .frame(height: 44)
            .background(Color.white.opacity(0.8))
            .foregroundColor(.black)
            .cornerRadius(5)
    }
}


#Preview {
    LandingPageView()
}

