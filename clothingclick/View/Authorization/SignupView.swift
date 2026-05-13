//
//  SignupView.swift
//  clothingclick
//
//  Created by DavidBisht on 13/05/26.
//

import SwiftUI

struct SignupView: View {
    
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: Field?
    @StateObject private var vm = SignupViewModel()
    @State private var isActiveLoginView: Bool = false
    @State var isPostLoginFlow: Bool = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Divider()
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            Text(Constants.pleaseEnterYourDetails)
                                .font(AppFont.medium.font(size: 20))
                                .foregroundStyle(AppColor.blackColor)
                            VStack(spacing: 10) {
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
                                
                                // Name Field
                                AppTextField(
                                    title: Constants.name,
                                    placeholder: Constants.enterHere,
                                    text: $vm.name,
                                    isSecure: .constant(false),
                                    focusField: .nameField,
                                    focusedField: $focusedField
                                )
                                .id(Field.nameField.hashValue)
                                
                                // Username Field
                                AppTextField(
                                    title: Constants.username,
                                    placeholder: Constants.enterHere,
                                    text: $vm.username,
                                    isSecure: .constant(false),
                                    focusField: .usernameField,
                                    focusedField: $focusedField
                                )
                                .id(Field.usernameField.hashValue)
                                
                                // Password Field
                                AppTextField(
                                    title: Constants.password,
                                    placeholder: Constants.enterHere,
                                    text: $vm.password,
                                    isSecure: $vm.hidePassword,
                                    focusField: .passwordField,
                                    focusedField: $focusedField,
                                    rightSideImage: Image(vm.hidePassword ? .openEye : .closedEye),
                                    rightSideAction: {
                                        vm.hidePassword.toggle()
                                        if focusedField == .passwordField {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                                focusedField = .passwordField
                                            }
                                        }
                                    }
                                )
                                .id(Field.passwordField.hashValue)
                                
                                HStack {
                                    
                                    validationIndicator(
                                        color: vm.passwordValidationStatus.isLengthValid ? AppColor.greenColor : AppColor.redColor,
                                        title: Constants._8Characters
                                    )
                                    
                                    validationIndicator(
                                        color: vm.passwordValidationStatus.hasUppercase ? AppColor.greenColor : AppColor.redColor,
                                        title: Constants._1Uppercase
                                    )
                                    
                                    validationIndicator(
                                        color: vm.passwordValidationStatus.hasNumber ? AppColor.greenColor : AppColor.redColor,
                                        title: Constants._1Number
                                    )
                                    
                                    Spacer()
                                }
                                
                                // Confirm Password Field
                                AppTextField(
                                    title: Constants.confirmPassword,
                                    placeholder: Constants.enterHere,
                                    text: $vm.confirmPassword,
                                    isSecure: $vm.hideConfirmPassword,
                                    focusField: .confirmPasswordField,
                                    focusedField: $focusedField,
                                    rightSideImage: Image(vm.hideConfirmPassword ? .openEye : .closedEye),
                                    rightSideAction: {
                                        vm.hideConfirmPassword.toggle()
                                        if focusedField == .confirmPasswordField {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                                focusedField = .confirmPasswordField
                                            }
                                        }
                                    }
                                )
                                .id(Field.confirmPasswordField.hashValue)
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
                
                Button(action: {
                    print("log in on tapped")
                    if isPostLoginFlow {
                        dismiss()
                    } else {
                        isActiveLoginView = true
                    }
                }) {
                    Text(Constants.logIn)
                        .font(AppFont.medium.font(size: 13))
                        .foregroundStyle(AppColor.blackColor)
                }
                .padding()
                
                CustomDivider(color: AppColor.borderColor, lineWidth: 1)
                Button(action: {
                    print("sign up on tapped")
                }) {
                    Text(Constants.signUp)
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
            .navigationDestination(isPresented: $isActiveLoginView) {
                LoginView(isPostSignupFlow: true)
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
    
    private func validationIndicator(color: Color, title: String) -> some View {
        HStack {
            Circle()
                .fill(color)
                .frame(width: 14, height: 14)
            Text(title)
                .font(AppFont.regular.font(size: 13))
                .foregroundStyle(AppColor.blackColor)
        }
    }
    
}

#Preview {
    SignupView()
}
