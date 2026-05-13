//
//  LoginView.swift
//  clothingclick
//
//  Created by DavidBisht on 13/05/26.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: Field?
    @StateObject private var vm = LoginViewModel()
    @State private var isActiveSignupView: Bool = false
    @State var isPostSignupFlow: Bool = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Divider()
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            Text(Constants.pleaseEnterYourLogInDetails)
                                .font(AppFont.medium.font(size: 20))
                                .foregroundStyle(AppColor.blackColor)
                            VStack(spacing: 10) {
                                // Login base on input Field
                                AppTextField(
                                    title: "\(Constants.phoneNumber),\(Constants.username)\(Constants.or.lowercased())\(Constants.email)",
                                    placeholder: Constants.enterHere,
                                    text: $vm.email,
                                    isSecure: .constant(false),
                                    focusField: .emailField,
                                    focusedField: $focusedField,
                                    keyboardType: .emailAddress
                                )
                                .id(Field.emailField.hashValue)
                                
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
                    print("sign up on tapped")
                    if isPostSignupFlow {
                        dismiss()
                    } else {
                        isActiveSignupView = true
                    }
                }) {
                    Text(Constants.signUp)
                        .font(AppFont.medium.font(size: 13))
                        .foregroundStyle(AppColor.blackColor)
                }
                .padding()
                
                CustomDivider(color: AppColor.borderColor, lineWidth: 1)
                Button(action: {
                    print("log in on tapped")
                }) {
                    Text(Constants.logIn)
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
            .navigationDestination(isPresented: $isActiveSignupView) {
                SignupView(isPostLoginFlow: true)
            }
            .navigationDestination(isPresented: $isActiveSignupView) {
                SignupView(isPostLoginFlow: true)
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
    
}

#Preview {
    LoginView()
}
