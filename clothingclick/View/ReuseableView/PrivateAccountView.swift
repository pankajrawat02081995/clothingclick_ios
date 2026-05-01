//
//  PrivateAccountView.swift
//  clothingclick
//
//  Created by DavidBisht on 28/04/26.
//

import SwiftUI

struct PrivateAccountView: View {
    var title: String = Constants.privateAccount
    var message: String = Constants.followThisAccountToSeeTheirListings

    var body: some View {
        VStack(spacing: 12) {
            Image("privateAccount")
                .font(.system(size: 40))
                .padding(.bottom, 8)

            Text(title)
                .font(AppFont.medium.font(size: 15))
                .foregroundStyle(AppColor.blackColor)
            Text(message)
                .font(AppFont.regular.font(size: 13))
                .foregroundStyle(AppColor.blackColor)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
#Preview {
    PrivateAccountView()
}
