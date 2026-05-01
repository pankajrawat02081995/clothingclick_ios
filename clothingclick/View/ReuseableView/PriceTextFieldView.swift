//
//  PriceTextFieldView.swift
//  clothingclick
//
//  Created by DavidBisht on 01/05/26.
//

import SwiftUI

struct PriceTextFieldView: View {
    
    let placeholder: String
    @Binding var text: String
    let type: TextFieldType
    let keyboardType: UIKeyboardType
    @Binding var selectedTextField: TextFieldType?
    @FocusState.Binding var focusedField: Bool
    
    var body: some View {
        HStack {
            Text("$")
                .font(AppFont.regular.font(size: 13))
                .foregroundStyle(AppColor.blackColor)

            TextField(
                "",
                text: $text,
                prompt: Text(placeholder)
                    .foregroundColor(Color(UIColor.placeholderText))
            )
            .font(AppFont.regular.font(size: 13))
            .foregroundStyle(AppColor.blackColor)
            .keyboardType(keyboardType)
            .focused($focusedField)
            .onChange(of: focusedField) { _, newValue in
                selectedTextField = type
            }

            Text(type.getValue())
                .font(AppFont.medium.font(size: 15))
                .foregroundStyle(AppColor.blackColor)
        }
        .padding()
        .background(AppColor.lightGrayColor)
        .cornerRadius(5)
        .clipped()
    }
}
//#Preview {
//    PriceTextFieldView()
//}
