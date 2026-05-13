//
//  SignUpPopupView.swift
//  clothingclick
//
//  Created by DavidBisht on 13/05/26.
//

import SwiftUI

struct SignUpPopupView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var isActiveSignupView: Bool = false
    @State private var isActiveTroubleloggingView: Bool = false
    @State private var isActiveConvertToStoreProfileView: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                VStack(spacing: 10) {
                    HStack {
                        Spacer()
                        Button(action:{
                            dismiss()
                        }) {
                            Image(.roundCross)
                        }
                    }
                    ZStack {
                        Text(Constants.AppName)
                            .font(AppFont.medium.font(size: 30))
                            .foregroundStyle(AppColor.grayColor)
                            .padding(.top, 10)
                            .shadow(radius: 4)
                        Text(Constants.AppName)
                            .font(AppFont.medium.font(size: 30))
                            .foregroundStyle(AppColor.blackColor)
                    }
                    
                    Text(Constants.localFashionResale)
                        .font(AppFont.medium.font(size: 15))
                        .foregroundStyle(AppColor.blackColor)
                        .padding(.bottom, 30)
                    
                    signupWith(title: Constants.continueWithFacebook, image: Image(.iconFacebook)) {
                        print("continueWithFacebook")
                    }
                    
                    signupWith(title: Constants.continueWithGoolge, image: Image(.iconGoogle)) {
                        print("continueWithGoolge")
                        isActiveConvertToStoreProfileView = true
                    }
                    
                    signupWith(title: Constants.continueWithApple, image: Image(.iconApple)) {
                        print("continueWithApple")
                    }
                    
                    signupWith(title: Constants.continueWithEmail, image: Image(.iconEmail)) {
                        isActiveSignupView = true
                    }
                    
                    Button(action: {
                        isActiveTroubleloggingView = true
                    }) {
                        Text(Constants.troubleLoggingIn)
                            .font(AppFont.regular.font(size: 10))
                            .foregroundStyle(AppColor.blackColor)
                    }
                    .padding(.top, 10)
                }
                .padding()
                .background(AppColor.whiteColor)
            }
        }
        .background(AppColor.blackColor.opacity(0.68))
        .navigationDestination(isPresented: $isActiveSignupView) {
            SignupView()
        }
        .navigationDestination(isPresented: $isActiveConvertToStoreProfileView) {
            ConvertToStoreProfileView()
        }
        .navigationDestination(isPresented: $isActiveTroubleloggingView) {
            TroubleloggingView()
        }
    }
    
    private func signupWith(title: String, image: Image, action: @escaping () -> Void) -> some View {
        Button(action: {
            action()
        }) {
            HStack {
                image
                Spacer()
                Text(title)
                    .font(AppFont.regular.font(size: 13))
                    .foregroundStyle(AppColor.blackColor)
                Spacer()
                image
                    .hidden()
            }
            .padding()
            .background(AppColor.lightGrayColor)
            .clipShape(RoundedRectangle(cornerRadius: 5))
        }
    }
    
}

#Preview {
    SignUpPopupView()
}
