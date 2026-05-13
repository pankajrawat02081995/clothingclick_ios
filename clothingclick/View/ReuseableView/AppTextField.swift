//
//  AppTextField.swift
//  clothingclick
//
//  Created by DavidBisht on 13/05/26.
//

import SwiftUI

struct AppTextField<Field: Hashable>: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    @Binding var isSecure: Bool
    
    // Focus management
    var focusField: Field
    @FocusState.Binding var focusedField: Field?
    
    // Optional customization
    var image: Image? = nil
    var keyboardType: UIKeyboardType = .default
    var rightSideImage: Image? = nil
    var rightSideAction: (() -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(AppFont.medium.font(size: 13))
                .foregroundStyle(AppColor.blackColor)
            
            HStack {
                if let leadingImage = image {
                    leadingImage
                }
                
                ZStack {
                    if isSecure {
                        SecureField("", text: $text, prompt: promptText)
                            .id("secure") // Important: forces refresh
                            .focused($focusedField, equals: focusField)
                    } else {
                        TextField("", text: $text, prompt: promptText)
                            .id("plain") // Important: forces refresh
                            .focused($focusedField, equals: focusField)
                    }
                }
                .keyboardType(keyboardType)
                .textFieldStyle(.plain)
                .font(AppFont.regular.font(size: 13))
                .foregroundStyle(AppColor.blackColor)
                
                if let rightImage = rightSideImage {
                    Button(action: { rightSideAction?() }) {
                        rightImage
                    }
                }
            }
            .padding(.horizontal)
            .frame(height: 44)
            .background(AppColor.lightGrayColor)
            .cornerRadius(5)
        }
    }
    
    private var promptText: Text {
        Text(placeholder)
            .font(AppFont.regular.font(size: 13))
            .foregroundStyle(AppColor.defaultPlaceholderTextColor)
    }
}
