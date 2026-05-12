//
//  PhotoGuideView.swift
//  clothingclick
//
//  Created by DavidBisht on 11/05/26.
//

import SwiftUI

struct PhotoGuideView: View {
    
    @Environment(\.dismiss) var dismiss
 
    // ("title", "description", "[image]")
    let photoGuides: [(String, String, [Image])] = [
        (Constants.guideCoverPhotoTitle, Constants.guideCoverPhotoDescription, [Image("guideCoverPhoto")]),
        (Constants.guideMorePhotosTitle, Constants.guideMorePhotosDescription, [Image("guideMorePhoto1"),Image("guideMorePhoto2"),Image("guideMorePhoto3"),Image("guideMorePhoto4"),Image("guideMorePhoto5"),Image("guideMorePhoto6"),Image("guideMorePhoto7"),Image("guideMorePhoto8"),Image("guideMorePhoto9")]),
        (Constants.indicateTheFlawsTitle, Constants.indicateTheFlawsDescription, [Image("guideIndicate")]),
        (Constants.brandTagRecommendedTitle, Constants.brandTagRecommendedTitleDescription, [Image("guideBrandTag")]),
        (Constants.packaginPhotosTitle, Constants.packaginPhotosDescription, [Image("guidePackaging")]),
        (Constants.sneakersFootwearPhotoGuideTitle, Constants.sneakersFootwearPhotoGuideDescription, [Image("guidePhoto")]),
        (Constants.outSoleTitle, Constants.outSoleDescription, [Image("guideOutSole")])
    ]
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    VStack(spacing: 30) {
                        ForEach(photoGuides.indices, id:\.self) { index in
                            let photoGuide = photoGuides[index]
                            if photoGuide.2.count > 1 {
                                guide(title: photoGuide.0, description: photoGuide.1, images: photoGuide.2)
                            } else if index == 0 {
                                guide(title: photoGuide.0, description: photoGuide.1, image: photoGuide.2.first, maxImageWidth: 170, maxImageHeight: 226)
                            } else {
                                guide(title: photoGuide.0, description: photoGuide.1, image: photoGuide.2.first)
                            }
                        }
                    }
                    .padding()
                }
                CustomDivider(color: AppColor.borderColor, lineWidth: 1)
                saveButton
                    .padding()
            }
        }
        .customNavigationBar(
            config:NavBarConfig(
                title: Constants.photoGuide.capitalized,
                font: AppFont.medium.font(size: 17),
                
                leading: NavBarItem(
                    title: nil,
                    font: AppFont.medium.font(size: 13.0, relativeTo: .title),
                    image: "back",
                    isSystemImage: false,
                    action: {
                        dismiss()
                    }
                )
            )
        )
        .toolbarBackground(.visible, for: .navigationBar)
    }

    
    private func guide(title: String, description: String, image: Image?, maxImageWidth: CGFloat = .infinity, maxImageHeight: CGFloat = .infinity) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(AppFont.medium.font(size: 17))
                .foregroundColor(AppColor.blackColor)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(description)
                .font(AppFont.regular.font(size: 15))
                .foregroundColor(AppColor.blackColor)
            if let image = image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: maxImageWidth)
                    .frame(maxHeight: maxImageHeight)
            } else {
                Image("")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: maxImageWidth)
                    .frame(maxHeight: maxImageHeight)
                    .background(AppColor.blackColor.opacity(0.07))
            }
        }
    }
    
    private func guide(title: String, description: String, images: [Image]) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(AppFont.medium.font(size: 17))
                .foregroundColor(AppColor.blackColor)
            Text(description)
                .font(AppFont.regular.font(size: 15))
                .foregroundColor(AppColor.blackColor)
            LazyVGrid(columns:[GridItem(),GridItem(),GridItem()]) {
                ForEach(images.indices, id: \.self) { index in
                    images[index]
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .frame(maxHeight: .infinity)
                        .background(AppColor.blackColor.opacity(0.07))
                }
            }
            .padding(.top,10)
        }
    }
    
    private var saveButton: some View {
        Button(action: {
            dismiss()
        }) {
            Text(Constants.gotIt)
                .frame(maxWidth: .infinity)
                .padding()
                .font(AppFont.regular.font(size: 15))
                .background(AppColor.blackColor)
                .foregroundColor(AppColor.whiteColor)
                .cornerRadius(5)
        }
    }
    
}

#Preview {
    PhotoGuideView()
}
