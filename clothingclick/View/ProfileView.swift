//
//  ProfileView.swift
//  clothingclick
//
//  Created by DavidBisht on 26/04/26.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var vm = ProfileViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                profileSection
                    .padding()
                Divider()
                
//                ProductGridView(products: vm.products)
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
                        print("back tapped")
                        self.dismiss()
                    }
                ),
                
                trailing: [NavBarItem(
                    title: "",
                    font: AppFont.medium.font(size: 13.0, relativeTo: .title),
                    image: "threedots",
                    isSystemImage: false,
                    action: {
                        print("dots tapped")
                    }
                )]
            )
        )
        .toolbarBackground(.visible, for: .navigationBar)
    }
    
    private var profileSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                AsyncImage(url: URL(string: "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Image(systemName: "")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 102, height: 102)
                .background(AppColor.borderColor)
                .clipShape(Circle())
                
                NavigationLink(destination: FollowersView(profile: User(name: "Aman", username: "aman243", followers: 232, isFollowing: true, image: ""))) {
                    VStack(alignment: .leading) {
                        Text("67")
                            .foregroundStyle(AppColor.blackColor)
                            .font(AppFont.medium.font(size: 15))
                        Text(Constants.posts)
                            .foregroundStyle(AppColor.darkGrayColor)
                            .font(AppFont.medium.font(size: 10))
                    }
                    .frame(maxWidth: .infinity)
                    .allowsHitTesting(false)
                    VStack(alignment: .leading) {                            Text("532")
                            .foregroundStyle(AppColor.blackColor)
                            .font(AppFont.medium.font(size: 15))
                        Text(Constants.following)
                            .foregroundStyle(AppColor.darkGrayColor)
                            .font(AppFont.medium.font(size: 10))
                    }
                    .frame(maxWidth: .infinity)
                    VStack(alignment: .leading) {
                        Text("232")
                            .foregroundStyle(AppColor.blackColor)
                            .font(AppFont.medium.font(size: 15))
                        Text(Constants.followers)
                            .foregroundStyle(AppColor.darkGrayColor)
                            .font(AppFont.medium.font(size: 10))
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Aman")
                        .foregroundStyle(AppColor.blackColor)
                        .font(AppFont.medium.font(size: 15))
                    Text("aman357")
                        .foregroundStyle(AppColor.darkGrayTextColor)
                        .font(AppFont.medium.font(size: 13))
                }
                Spacer()
                
                Button(action: {
                }) {
                    HStack {
                        Image(.share)
                            .renderingMode(.template)
                    }
                    .frame(width: 34, height: 34)
                    .background(AppColor.blackColor)
                    .foregroundStyle(AppColor.whiteColor)
                    .cornerRadius(5)
                    
                }
                
                Button(action: {
                    vm.isFollowing.toggle()
                }) {
                    Text(vm.isFollowing ? Constants.following : Constants.follow)
                        .frame(width: 90, height: 32)
                        .font(AppFont.medium.font(size: 13))
                        .background(vm.isFollowing ? AppColor.whiteColor : AppColor.blackColor)
                        .foregroundColor(vm.isFollowing ? AppColor.blackColor : AppColor.whiteColor)
                        .cornerRadius(5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(AppColor.blackColor,lineWidth: 1)
                        }
                }
            }
            HStack(alignment: .center, spacing: 2) {
                Image(.star)
                
                Text("4.9 (9 \(Constants.reviews)")
                    .font(AppFont.regular.font(size: 13))
                    .foregroundStyle(AppColor.blackColor)
            }
            Text("Auctor quis sagittis sit ac et praesent nulla malesuada. Purus ornare eget quisque tellus dui a eu. Enim tincidunt sagittis hac tincidunt. Vehicula elit massa nibh a at. Interdum lacinia eu sem malesuada.")
                .font(AppFont.regular.font(size: 13))
                .foregroundStyle(AppColor.blackColor)
        }
    }
}

#Preview {
    ProfileView()
}
