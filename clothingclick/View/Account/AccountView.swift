//
//  AccountView.swift
//  clothingclick
//
//  Created by DavidBisht on 12/05/26.
//

import SwiftUI

struct AccountView: View {
    
    @StateObject var vm = AccountViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var isActiveFilterView: Bool = false
    @State private var isActiveEditProfileView: Bool = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    profileSection
                        .padding()
                    Divider()
                        .padding(0)
                    if vm.products.count == 0 {
                        PrivateAccountView()
                            .padding()
                    } else {
                        sellingAndSoldSection
                            .padding(0)
                    }
                }
                .onAppear() {
                    vm.isFacebookLinked = true
                    vm.isInstagramLinked = true
                }
                
            }
        }
        .navigationDestination(isPresented: $isActiveEditProfileView, destination: {
            EditProfileView()
        })
        .customNavigationBar(
            config:NavBarConfig(
                title: "Aman",
                font: AppFont.medium.font(size: 13.0),
                
//                leading: NavBarItem(
//                    title: "",
//                    font: AppFont.medium.font(size: 13.0, relativeTo: .title),
//                    image: "back",
//                    isSystemImage: false,
//                    action: {
//                        dismiss()
//                    }
//                ),
                
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
                    VStack(alignment: .leading) {
                        Text("532")
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
                        Image(.setting)
                    }
                    .frame(width: 34, height: 34)
                    .onTapGesture {
                       
                    }
                }
                
                Button(action: {
                    isActiveEditProfileView = true
                }) {
                    Text(Constants.editProfile)
                        .frame(width: 90, height: 32)
                        .font(AppFont.medium.font(size: 13))
                        .background(AppColor.whiteColor)
                        .foregroundColor(AppColor.blackColor)
                        .cornerRadius(5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(AppColor.blackColor,lineWidth: 1)
                        }
                }
            }
            HStack(alignment: .center, spacing: 2) {
                Image(.star)
                NavigationLink {
                    ReviewsView()
                } label: {
                    Text("4.9 (9 \(Constants.reviews))")
                        .font(AppFont.regular.font(size: 13))
                        .foregroundStyle(AppColor.blackColor)
                }
            }
            Text("Auctor quis sagittis sit ac et praesent nulla malesuada. Purus ornare eget quisque tellus dui a eu. Enim tincidunt sagittis hac tincidunt. Vehicula elit massa nibh a at. Interdum lacinia eu sem malesuada.")
                .font(AppFont.regular.font(size: 13))
                .foregroundStyle(AppColor.blackColor)
            if vm.isFacebookLinked || vm.isInstagramLinked {
                HStack {
                    if vm.isFacebookLinked {
                        Button(action: { }) {
                            HStack {
                                Image(.roundFacebookLogo)
                                    .cornerRadius(5)
                                    .padding(5)
                                    .frame(maxWidth: .infinity)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(AppColor.borderColor,lineWidth: 1)
                                    }
                            }
                               
                        }
                    }
                    if vm.isInstagramLinked {
                        Button(action: { }) {
                            HStack {
                                Image(.instagramLogo)
                                    .cornerRadius(5)
                                    .padding(5)
                                    .frame(maxWidth: .infinity)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(AppColor.borderColor,lineWidth: 1)
                                    }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private var sellingAndSoldSection: some View {
        VStack {
            CustomTabBarView(
                tabs: vm.tabs,
                selectedTab: vm.selectedTab,
                title: { $0 + "(236)"}
            ) { tab in
                vm.selectedTab = tab
            }
            HStack {
                Text("AI Selling")
                    .foregroundStyle(AppColor.blackColor)
                    .font(AppFont.regular.font(size: 17))
                Spacer()
                Button {
                    isActiveFilterView = true
                } label: {
                    HStack {
                        Image("filter")
                        Text("Filter")
                            .foregroundStyle(AppColor.blackColor)
                            .font(AppFont.regular.font(size: 13))
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical,10)
            
            ProductGridView(
                title: nil,
                items: vm.products,
                columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ],
                content: { product in
                    ProductCardView(
                        imageURL: product.image,
                        title: product.name,
                        price: "$\(product.price)",
                        isFavorite: product.isFavorite
                    ) {
                        vm.toggleFavorite(product)
                    }
                },
                destination: { product in
                    ProductDetailView(product: product)
                }
            )
            .padding(.horizontal)
        }
        .navigationDestination(isPresented: $isActiveFilterView) {
            FilterView()
        }
    }
}

#Preview {
    AccountView()
}
