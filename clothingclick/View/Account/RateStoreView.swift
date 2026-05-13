//
//  RateStoreView.swift
//  clothingclick
//
//  Created by DavidBisht on 12/05/26.
//

import SwiftUI
import PhotosUI

struct RateStoreView: View {

    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = RateStoreViewModel()
    @FocusState var isFocused: Bool
    @StateObject private var imagePicker = ImagePickerManager()

    var body: some View {

        ZStack {
            VStack(spacing: 0) {
                
                ScrollView {
                    
                    VStack(spacing: 24) {
                        storeProfileSection
                        VStack(spacing: 8) {
                            
                            Text(Constants.howWasYourExperienceWithThisStore)
                                .font(AppFont.medium.font(size: 20))
                                .foregroundStyle(AppColor.blackColor)
                                .multilineTextAlignment(.center)
                            
                            Text(Constants.ratingsAndReviewsOfBuyersAndSellersAreVisibleToEveryoneOnClothingClick)
                                .font(AppFont.regular.font(size: 15))
                                .foregroundStyle(AppColor.darkGrayColor)
                                .multilineTextAlignment(.center)
                        }
                        
                        RatingStarsView(
                            selectedRating: $viewModel.selectedRating
                        )
                        
                        VStack(alignment: .leading, spacing: 8) {
                            
                            Text(Constants.description)
                                .font(AppFont.medium.font(size: 13))
                                .foregroundStyle(AppColor.blackColor)
                            
                            CustomTextEditor(text: $viewModel.description, isFocused: $isFocused, placeholder: Constants.addHere, cornerRadius: 0,placeholderColor: AppColor.blackColor, backgroundColor: AppColor.clearColor, strokeColor: AppColor.clearColor, minHeight: 102, maxHeight: 102)
                                .padding(11)
                                .background(AppColor.lightGrayColor)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            
                            Text(Constants.photos)
                                .font(AppFont.medium.font(size: 13))
                                .foregroundStyle(AppColor.blackColor)
                            
                            Button(action:{
                                imagePicker.openPicker(type: .single)
                            }) {
                                photoUploadView
                            }
                        }
                    }
                    .padding()
                }
                .scrollDismissesKeyboard(.interactively)
                
                Divider()
                
                Button(action: {
                    viewModel.submitReview()
                }) {
                    Text(Constants.done)
                        .font(AppFont.medium.font(size: 15))
                        .foregroundStyle(AppColor.whiteColor)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(AppColor.blackColor)
                        .cornerRadius(5)
                }
                .padding()
            }
        }
        .customNavigationBar(
            config:NavBarConfig(
                title: Constants.sell,
                font: AppFont.medium.font(size: 13.0),
                
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
    
    private var storeProfileSection: some View {
        VStack(spacing: 12) {

            Image(.guideMorePhoto2)
                .resizable()
                .scaledToFit()
                .frame(width: 112, height: 112)
                .background(AppColor.blackColor.opacity(0.2))
                .clipShape(Circle())

            VStack(spacing: 4) {

                HStack(spacing: 4) {

                    Text(viewModel.store.storeName)
                        .font(AppFont.regular.font(size: 15))
                        .foregroundStyle(AppColor.blackColor)
                    Image(.blueTick)
                }

                Text(viewModel.store.username)
                    .font(AppFont.regular.font(size: 13))
                    .foregroundStyle(AppColor.blackColor)
            }
        }
    }
    
    private var photoUploadView: some View {
        VStack(spacing: 10) {
            if let image = viewModel.selectedImages {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 60)
                    .clipped()
            } else {
                Image(.addPhotos)
                Text(Constants.addPhoto)
                    .font(AppFont.medium.font(size: 10))
                    .foregroundStyle(AppColor.blackColor)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(AppColor.borderColor)
        )
        // MARK: - Source Dialog

        .confirmationDialog(
            Constants.addressesAreSecureAndEncrypted,
            isPresented: $imagePicker.showSourceDialog
        ) {

            Button(Constants.camera) {
                imagePicker.handleSource(.camera)
            }

            Button(Constants.gallery) {
                imagePicker.handleSource(.gallery)
            }
        }

        // MARK: - Gallery Single

        .photosPicker(
            isPresented: Binding(
                get: {
                    imagePicker.showGallery &&
                    imagePicker.selectionType == .single
                },
                set: { imagePicker.showGallery = $0 }
            ),
            selection: $imagePicker.photoItem,
            matching: .images
        )

        // MARK: - Camera
        .sheet(isPresented: $imagePicker.showCamera) {
            CameraPicker { image in
                imagePicker.setCameraImage(image)
            }
        }

        // MARK: - Load Images
        .onChange(of: imagePicker.photoItem) { _,_ in
            Task {
                await imagePicker.loadSingleImage()
                if let selectedImage = imagePicker.selectedImage {
                    viewModel.selectedImages = selectedImage
                }
            }
          
        }
    }
    
}

#Preview {
    RateStoreView()
}
