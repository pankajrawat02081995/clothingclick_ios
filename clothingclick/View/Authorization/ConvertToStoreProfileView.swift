//
//  ConvertToStoreProfileView.swift
//  clothingclick
//
//  Created by DavidBisht on 13/05/26.
//

import SwiftUI

struct ConvertToStoreProfileView: View {
    
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: Field?
    @FocusState private var isFocused: Bool
    @StateObject private var vm = ConvertToStoreProfileViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Divider()
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            Text(Constants.convertToStoreProfile)
                                .font(AppFont.medium.font(size: 20))
                                .foregroundStyle(AppColor.blackColor)
                            Text(Constants.weWillReviewYourApplicationAndContactYouShortly)
                                .font(AppFont.regular.font(size: 13))
                                .foregroundStyle(AppColor.blackColor)
                                .padding(.bottom, 10)
                            VStack(spacing: 10) {
                                
                                // Store Name Field
                                AppTextField(
                                    title: Constants.storeName,
                                    placeholder: Constants.enterHere,
                                    text: $vm.storeName,
                                    isSecure: .constant(false),
                                    focusField: .storenameField,
                                    focusedField: $focusedField
                                )
                                .id(Field.storenameField.hashValue)
                                
                                // Store address Field
                                AppTextField(
                                    title: Constants.storeAddress,
                                    placeholder: Constants.enterHere,
                                    text: $vm.storeAddress,
                                    isSecure: .constant(false),
                                    focusField: .storeAddressField,
                                    focusedField: $focusedField
                                )
                                .id(Field.storeAddressField.hashValue)
                                
                                // Phone number Field
                                AppTextField(
                                    title: Constants.phoneNumber,
                                    placeholder: Constants.enterHere,
                                    text: $vm.phoneNumber,
                                    isSecure: .constant(false),
                                    focusField: .phoneNumberField,
                                    focusedField: $focusedField,
                                    keyboardType: .numberPad
                                )
                                .id(Field.phoneNumberField.hashValue)
                                
                                // Email Field
                                AppTextField(
                                    title: Constants.email,
                                    placeholder: Constants.enterHere,
                                    text: $vm.email,
                                    isSecure: .constant(false),
                                    focusField: .emailField,
                                    focusedField: $focusedField,
                                    keyboardType: .emailAddress
                                )
                                .id(Field.emailField.hashValue)
                                
                                // Website Field
                                AppTextField(
                                    title: Constants.website,
                                    placeholder: Constants.enterHere,
                                    text: $vm.website,
                                    isSecure: .constant(false),
                                    focusField: .websiteField,
                                    focusedField: $focusedField
                                )
                                .id(Field.websiteField.hashValue)
                                
                                // Optional Message Field
                               messageField
                            }
                            .toolbar {
                                // Only show the toolbar when this specific field is focused
                                if focusedField == .phoneNumberField || isFocused {
                                    ToolbarItemGroup(placement: .keyboard) {
                                        Spacer()
                                        Button(Constants.done) {
                                            focusedField = nil // This hides the keyboard
                                            isFocused = false
                                        }
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                    .onChange(of: focusedField) { _, field in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            withAnimation {
                                if let field = field {
                                    proxy.scrollTo(field.hashValue)
                                }
                            }
                        }
                    }
                    .scrollDismissesKeyboard(.interactively)
                }
               
                
                CustomDivider(color: AppColor.borderColor, lineWidth: 1)
                Button(action: {
                    print("submit on tapped")
                }) {
                    Text(Constants.submit)
                        .font(AppFont.medium.font(size: 15))
                        .foregroundStyle(AppColor.whiteColor)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(AppColor.blackColor)
                        .cornerRadius(5)
                }
                .padding()
            }
            .onAppear() {
            }
            .customNavigationBar(config: NavBarConfig(
                title: Constants.AppName,
                titleImage: nil,
                font: AppFont.medium.font(size: 15),
                leading:  NavBarItem(
                    title: "",
                    font: .system(size: 14),
                    image: "back",
                    isSystemImage: false,
                    tint: .black,
                    action: {
                        dismiss()
                    }
                )
            ))
            .toolbar(.hidden, for: .tabBar)
        }
    }
    
    private var messageField: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            Text(Constants.description)
                .font(AppFont.medium.font(size: 13))
                .foregroundStyle(AppColor.blackColor)
            
            CustomTextEditor(text: $vm.message, isFocused: $isFocused, placeholder: Constants.optional, cornerRadius: 0,placeholderColor: AppColor.blackColor, backgroundColor: AppColor.clearColor, strokeColor: AppColor.clearColor, minHeight: 87, maxHeight: 87)
                .padding(11)
                .background(AppColor.lightGrayColor)
        }
    }
    
}

#Preview {
    ConvertToStoreProfileView()
}
