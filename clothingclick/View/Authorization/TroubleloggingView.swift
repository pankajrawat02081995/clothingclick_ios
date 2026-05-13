//
//  TroubleloggingView.swift
//  clothingclick
//
//  Created by DavidBisht on 13/05/26.
//

import SwiftUI

struct TroubleloggingView: View {
    
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: Field?
    @StateObject private var vm = TroubleloggingViewModel()
    @State private var isActiveCodeVerificationView: Bool = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Divider()
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(Constants.troubleLoggingIn)
                                .font(AppFont.medium.font(size: 20))
                                .foregroundStyle(AppColor.blackColor)
                            Text(Constants.troubleLoggingInSubTitle)
                                .font(AppFont.medium.font(size: 13))
                                .foregroundStyle(AppColor.blackColor)
                            
                            Text(Constants.yourPhoneNumber)
                                .font(AppFont.medium.font(size: 20))
                                .foregroundStyle(AppColor.blackColor)
                                .padding(.bottom,10)
                            
                            // Phone number Field
                            AppTextField(
                                title: "CA  +1",
                                placeholder: Constants.enterHere,
                                text: $vm.phoneNumber,
                                isSecure: .constant(false),
                                focusField: .phoneNumberField,
                                focusedField: $focusedField,
                                keyboardType: .numberPad
                            )
                            .id(Field.phoneNumberField.hashValue)
                            .toolbar {
                                // Only show the toolbar when this specific field is focused
                                if focusedField != nil {
                                    ToolbarItemGroup(placement: .keyboard) {
                                        Spacer()
                                        Button(Constants.done) {
                                            focusedField = nil // This hides the keyboard
                                        }
                                    }
                                }
                            }
                            
                            Text(Constants.troubleLoggingInDataRatesMayApply)
                                .font(AppFont.regular.font(size: 13))
                                .foregroundStyle(AppColor.darkGrayColor)
                        }
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
                
                .padding()
                
                CustomDivider(color: AppColor.borderColor, lineWidth: 1)
                Button(action: {
                    isActiveCodeVerificationView = true
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
            .onAppear() {
            }
            .navigationDestination(isPresented: $isActiveCodeVerificationView, destination: {
                CodeVerificationView()
            })
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
    
}

#Preview {
    TroubleloggingView()
}
