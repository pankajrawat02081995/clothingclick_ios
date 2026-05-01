//
//  StoreProfileView.swift
//  clothingclick
//
//  Created by DavidBisht on 27/04/26.
//

import SwiftUI

struct StoreProfileView: View {
    
    @StateObject var vm = ProfileViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var isActiveFollowersView: Bool = false
    @State private var showSheetStoreHoursView = false
    @State private var showSheetContactsSheetView = false

    var body: some View {
        ZStack {
            
        ScrollView {
            ZStack {
                VStack {
                    AsyncImage(url: URL(string: "")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 150)
                            .clipShape(Rectangle())
                    } placeholder: {
                        Image(systemName: "volleyball.fill")
                            .resizable(resizingMode: .tile)
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 150)
                            .clipShape(Rectangle())
                            .foregroundStyle(AppColor.greenColor)
                            .background(AppColor.lightGreenColor.opacity(0.2))
                    }
                    .frame(maxWidth: .infinity)
                    Spacer()
                }
                VStack(alignment: .leading, spacing: 0) {
                    profileSection
                        .padding(.top, 80)
                        .padding()
                    Divider()
                        .padding(0)
                    sellingAndSoldSection
                        .padding(0)
                }
            }
                .navigationDestination(isPresented: $isActiveFollowersView) {
                    FollowersView(profile: User(name: "Aman", username: "aman243", followers: 232, isFollowing: true, image: ""))
                }
            }
            .onAppear() {
                vm.isFacebookLinked = true
                vm.isInstagramLinked = true
            }
            
            OverFullScreenSheet(isPresented: $showSheetStoreHoursView) {
                VStack {
                    StoreHoursView(hours: [
                        ("Monday", "10:00am - 10:00pm"),
                        ("Tuesday", "10:00am - 10:00pm"),
                        ("Wednesday", "10:00am - 10:00pm"),
                        ("Thursday", "10:00am - 10:00pm"),
                        ("Friday", "10:00am - 10:00pm"),
                        ("Saturday", "10:00am - 10:00pm"),
                        ("Sunday", "10:00am - 10:00pm")
                    ])
                }
                .safeAreaPadding(.bottom)
            }
            
            OverFullScreenSheet(isPresented: $showSheetContactsSheetView) {
                VStack {
                    ContactsSheetView()
                }
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
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("67")
                            .foregroundStyle(AppColor.blackColor)
                            .font(AppFont.medium.font(size: 15))
                        Text(Constants.posts)
                            .foregroundStyle(AppColor.darkGrayColor)
                            .font(AppFont.medium.font(size: 10))
                    }
                    .frame(maxWidth: .infinity)
                    
                    VStack(alignment: .leading) {
                        Text("532")
                            .foregroundStyle(AppColor.blackColor)
                            .font(AppFont.medium.font(size: 15))
                        Text(Constants.following)
                            .foregroundStyle(AppColor.darkGrayColor)
                            .font(AppFont.medium.font(size: 10))
                    }
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        isActiveFollowersView = true
                    }
                    VStack(alignment: .leading) {
                        Text("232")
                            .foregroundStyle(AppColor.blackColor)
                            .font(AppFont.medium.font(size: 15))
                        Text(Constants.followers)
                            .foregroundStyle(AppColor.darkGrayColor)
                            .font(AppFont.medium.font(size: 10))
                    }
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        isActiveFollowersView = true
                    }
                }
                .padding(.top, 50)
                
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
            
            Link("Open Apple apple.com", destination: URL(string: "https://apple.com")!)
            
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
            
            HStack(spacing: 2) {
                Image(.clock)
                Text("Open")
                    .font(AppFont.regular.font(size: 13))
                    .foregroundStyle(AppColor.greenColor)
                Text("until 8:00 PM")
                    .font(AppFont.regular.font(size: 13))
                    .foregroundStyle(AppColor.blackColor)
                Image(.downArrow)
            }
            .onTapGesture {
                showSheetStoreHoursView = true
            }
            
            HStack {
                IconButtonView(image: Image(.chatfill), title: "Contact", action: {
                    showSheetContactsSheetView = true
                })
                IconButtonView(image: Image(.direction), title: "Direction", action: {
                    print("Direction")
                })
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
    }
}


#Preview {
    StoreProfileView()
}
