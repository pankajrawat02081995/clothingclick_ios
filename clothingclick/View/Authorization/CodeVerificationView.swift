//
//  CodeVerificationView.swift
//  clothingclick
//
//  Created by DavidBisht on 13/05/26.
//

import SwiftUI

struct CodeVerificationView: View {
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusField: Int? // Use Int for easier math
    
    // Use an array to store 6 digits
    @State private var otpValues: [String] = Array(repeating: "", count: 6)
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text(Constants.enterYourCode)
                        .font(AppFont.medium.font(size: 20))
                        .foregroundStyle(AppColor.blackColor)
                    
                    otpSection
                    
                    resendButton
                }
                .padding()
            }
            .scrollDismissesKeyboard(.interactively)
            
            bottomActionSection
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
    
    private var otpSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(Constants.myCodeIs)
                .font(AppFont.medium.font(size: 13))
            
            HStack(spacing: 8) {
                ForEach(0..<6, id: \.self) { index in
                    otpField(at: index)
                }
            }
        }
    }
    
    @ViewBuilder
    private func otpField(at index: Int) -> some View {
        TextField("", text: $otpValues[index], prompt: Text("0"))
            .font(AppFont.regular.font(size: 13))
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .textContentType(.oneTimeCode) // Allows iOS to auto-fill SMS codes
            .focused($focusField, equals: index)
            .padding()
            .frame(maxWidth: .infinity) // Ensures boxes are equal width
            .background(AppColor.lightGrayColor)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .toolbar {
                // Only show the toolbar when this specific field is focused
                if focusField == index {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button(Constants.done) {
                            focusField = nil // This hides the keyboard
                        }
                    }
                }
            }
            .onChange(of: otpValues[index]) { _, newValue in
                handleTextChange(at: index, value: newValue)
            }
    }
    
    private func handleTextChange(at index: Int, value: String) {
        // 1. If more than 1 char is entered (pasted or typed fast)
        if value.count > 1 {
            let lastChar = String(value.suffix(1))
            otpValues[index] = lastChar
            
            // Move to next field
            if index < 5 {
                focusField = index + 1
            }
        }
        
        // 2. If exactly 1 char is entered, move focus forward
        if value.count == 1 && index < 5 {
            focusField = index + 1
        }
        
        // 3. If deleted, move focus backward
        if value.isEmpty && index > 0 {
            focusField = index - 1
        }
    }
    
    private var resendButton: some View {
        Button(action: { /* Resend logic */ }) {
            Text(Constants.resendCode)
                .font(AppFont.regular.font(size: 13))
                .foregroundStyle(AppColor.blackColor)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding()
    }
    
    private var bottomActionSection: some View {
        VStack {
            CustomDivider(color: AppColor.borderColor, lineWidth: 1)
            Button(action: {
                let finalOTP = otpValues.joined()
                print("OTP is: \(finalOTP)")
            }) {
                Text(Constants.next)
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
}

#Preview {
    CodeVerificationView()
}
