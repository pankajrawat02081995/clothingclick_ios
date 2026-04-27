//
//  UserRowView.swift
//  clothingclick
//
//  Created by DavidBisht on 26/04/26.
//

import SwiftUI

struct UserRowView: View {
    
    let user: User
    let onFollow: () -> Void
    
    var body: some View {
        HStack {
            Image(user.image)
                .resizable()
                .frame(width: 54, height: 54)
                .background(AppColor.borderColor)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(user.name)
                    .font(AppFont.regular.font(size: 13))
                    .foregroundStyle(AppColor.blackColor)
                Text("\(user.followers) \(Constants.followers)")
                    .font(AppFont.regular.font(size: 13))
                    .foregroundStyle(AppColor.grayTextColor)
            }
            
            Spacer()
            
            Button(action: onFollow) {
                Text(user.isFollowing ? Constants.following : Constants.follow)
                    .frame(width: 90, height: 32)
                    .font(AppFont.medium.font(size: 13))
                    .background(user.isFollowing ? AppColor.whiteColor : AppColor.blackColor)
                    .foregroundColor(user.isFollowing ? AppColor.blackColor : AppColor.whiteColor)
                    .cornerRadius(5)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(AppColor.blackColor,lineWidth: 1)
                    }
            }
        }
    }
}

#Preview {
    UserRowView(user: User(name: "Aman", username: "aman23m", followers: 366, isFollowing: true, image: ""), onFollow: { })
}
