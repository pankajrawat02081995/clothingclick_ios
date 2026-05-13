//
//  EditProfileView.swift
//  clothingclick
//
//  Created by DavidBisht on 12/05/26.
//

import SwiftUI

struct EditProfileView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm = EditProfileViewModel()
    @FocusState private var focusedField: Field?
    @FocusState private var isBioField: Bool
    
    var body: some View {
        ZStack {
            ScrollView {
                ScrollViewReader { ScrollViewProxy in
                    VStack(spacing: 20) {
                        VStack(spacing: 20) {
                            profileSection
                            fieldsSection
                            addressSection
                        }
                        .padding()
                        linksSocialAccounts
                    }
                }
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
                        dismiss()
                    }
                )
            )
        )
        .toolbarBackground(.visible, for: .navigationBar)
    }
    
    private var profileSection: some View {
        VStack {
            if let image = vm.profilePicture {
                Image(.placeholder)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 110, height: 110)
                    .clipShape(Circle())
            } else {
                Text(vm.name.prefix(1).capitalized)
                    .font(AppFont.medium.font(size: 32))
                    .foregroundStyle(AppColor.whiteColor)
                    .frame(width: 110, height: 110)
                    .background(AppColor.blackColor)
                    .clipShape(Circle())
            }
            Text(Constants.changePhoto)
                .font(AppFont.medium.font(size: 13))
                .foregroundStyle(AppColor.blackColor)
                .onTapGesture {
                    
                }
        }
    }
    
    private var fieldsSection: some View {
        VStack(spacing: 10) {
            textFieldWithTitle(Constants.enterHere, text: $vm.name, title: Constants.name, focusStateField: .nameField)
            textFieldWithTitle(Constants.enterHere, text: $vm.username, title: Constants.username, focusStateField: .usernameField)
            textEditorWithTitle(Constants.enterHere, text: $vm.bio, title: Constants.bio, focusStateField: $isBioField)
        }
    }
    
    private var addressSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(Constants.address)
                .font(AppFont.medium.font(size: 17))
                .foregroundStyle(AppColor.blackColor)
            HStack {
                Text(Constants.selectAddress)
                    .font(AppFont.regular.font(size: 13.0))
                    .foregroundStyle(AppColor.blackColor)
                Spacer()
                Image(.rightArrow)
            }
            .padding(14)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .fill(AppColor.clearColor)
                    .stroke(AppColor.blackColor, lineWidth: 1)
            }
        }
    }
    
    private var linksSocialAccounts: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(Constants.linksSocialAccounts)
                .font(AppFont.medium.font(size: 15))
                .foregroundStyle(AppColor.blackColor)
                .padding(.bottom,10)
                .padding(.horizontal)
            socialAccount(title: Constants.linkYourInstagramAccount, image: Image(.instagramLogo)) {
                print("Instagram")
            }
            .padding()
            CustomDivider(color: AppColor.borderColor, lineWidth: 1)
            socialAccount(title: Constants.linkYourFacebookAccount, image: Image(.roundFacebookLogo)) {
                print("facebook")
            }
            .padding()
            CustomDivider(color: AppColor.borderColor, lineWidth: 1)
        }
    }
    
    
    private func socialAccount(
        title: String,
        image: Image,
        action: @escaping () -> Void
    ) -> some View {
        
        HStack {
            image
            
            Text(title)
                .font(AppFont.regular.font(size: 13))
                .foregroundStyle(AppColor.blackColor)
            
            Spacer()
            
            Image(.rightArrow)
                .renderingMode(.template)
                .foregroundStyle(AppColor.borderColor)
        }
        .onTapGesture {
            action()
        }
    }
    
    private func textFieldWithTitle(_ placeholder: String, text: Binding<String>, title: String, focusStateField: Field, image: Image? = nil, placeholderTextColor: Color? = nil, keyboardType: UIKeyboardType = .namePhonePad) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(AppFont.medium.font(size: 13))
                .foregroundStyle(AppColor.blackColor)
            HStack {
                image
                TextField(
                    "",
                    text: text,
                    prompt: Text(placeholder)
                        .font(AppFont.regular.font(size: 13))
                        .foregroundStyle(placeholderTextColor != nil ? placeholderTextColor! : AppColor.defaultPlaceholderTextColor)
                )
                .keyboardType(keyboardType)
                .textFieldStyle(.plain)
                .focused($focusedField, equals: focusStateField)
                .font(AppFont.regular.font(size: 13))
                .foregroundStyle(AppColor.blackColor)
            }
            .padding()
            .background(AppColor.lightGrayColor)
            .cornerRadius(5)
        }
    }
    
    private func textEditorWithTitle(_ placeholder: String, text: Binding<String>, title: String, focusStateField: FocusState<Bool>.Binding) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(AppFont.medium.font(size: 13))
                .foregroundStyle(AppColor.blackColor)
            
                CustomTextEditor(
                    text: text,
                    isFocused: focusStateField,
                    placeholder: Constants.typeHere,
                    cornerRadius: 0,
                    placeholderColor: AppColor.defaultPlaceholderTextColor,
                    textColor: AppColor.blackColor,
                    backgroundColor: AppColor.clearColor,
                    strokeColor: AppColor.clearColor,
                    uiFont: AppFont.regular.uiFont(size: 13),
                    minHeight: 120,
                    maxHeight: 120
                )
                .padding()
                .background(AppColor.lightGrayColor)
                .cornerRadius(5)
            
        }
    }
    
}

#Preview {
    EditProfileView()
}
