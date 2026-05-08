//
//  MessagesView.swift
//  clothingclick
//
//  Created by DavidBisht on 07/05/26.
//

import SwiftUI

struct MessagesView: View {
    
    @StateObject private var vm = MessagesViewModel()
    @FocusState var searchFocusState: Bool
    @State private var isActiveChatView: Bool = false
    @State private var selectedChatProfile: User?
    private let buyingColumns = [
        GridItem(.flexible())
    ]
    private let sellingColumns = [
        GridItem(.flexible())
    ] // GridItem(.flexible(), spacing: 16)
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                CustomTabBarView(
                    tabs: MessagesViewTabs.allCases,
                    selectedTab: vm.selectedTab,
                    title: { $0.rawValue }
                ) { tab in
                    vm.selectedTab = tab
                }
                searchAndFilterView
                    .padding()
                ScrollView {
                    VStack(spacing: 12) {
                        LazyVGrid(
                            columns: vm.selectedTab == .buying ? buyingColumns : sellingColumns,
                            spacing: 16
                        ) {
                            switch vm.selectedTab {
                            case .buying:
                                if $vm.filteredBuyingProfiles.isEmpty {
                                    Text(Constants.noResultsFound)
                                        .foregroundColor(.gray)
                                        .padding(.top, 40)
                                } else {
                                    ForEach(vm.filteredBuyingProfiles, id: \.id) { profile in
                                        profileCard(profile)
                                        CustomDivider(color: AppColor.borderColor, lineWidth: 1)
                                    }
                                }
                            case .selling:
                                if vm.filteredSellingProfiles.isEmpty {
                                    Text(Constants.noResultsFound)
                                        .foregroundColor(.gray)
                                        .padding(.top, 40)
                                } else {
                                    ForEach(vm.filteredSellingProfiles, id: \.id) { profile in
                                        profileCard(profile)
                                        CustomDivider(color: AppColor.borderColor, lineWidth: 1)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationDestination(isPresented: $isActiveChatView, destination: {
                ChatView(titleString: (selectedChatProfile?.name ?? ""), vm: ChatViewModel(chatID: "89445"))
            })
            .customNavigationBar(config: NavBarConfig(
                title: Constants.messages,
                font: AppFont.medium.font(size: 15)
            ))
            .onAppear() {
                vm.mockData()
            }
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
    
    var searchAndFilterView: some View {
        HStack(spacing: 10) {
            TextField(
                "",
                text: $vm.search,
                prompt: Text(Constants.searchProfiles)
                    .foregroundColor(AppColor.blackColor)
            )
            .font(AppFont.regular.font(size: 13))
            .foregroundStyle(AppColor.blackColor)
            .submitLabel(.search)
            .onSubmit {
                vm.searchResult()
            }
            .onChange(of: vm.search) { _, _ in
                vm.searchResult()
            }
            
            Image(.search)
        }
        .padding(12)
        .background(AppColor.lightGrayColor)
        .cornerRadius(10)
    }
    
    
//    private func productCard(_ product: Product) -> some View {
//        VStack(alignment: .leading, spacing: 8) {
//            
//            AsyncImage(url: URL(string: product.image)) { image in
//                image
//                    .resizable()
//                    .scaledToFit()
//            } placeholder: {
//                AppColor.borderColor
//            }
//            .frame(height: 157)
//            .frame(maxWidth: .infinity)
//            .clipped()
//            .border(AppColor.borderColor, width: 1)
//            
//            HStack {
//                Text(product.name)
//                    .font(AppFont.regular.font(size: 13))
//                    .foregroundStyle(AppColor.blackColor)
//                    .lineLimit(1)
//                Spacer()
//                Image(.heart)
//            }
//
//            Text("$\(product.price)")
//                .font(AppFont.medium.font(size: 15))
//                .foregroundStyle(AppColor.blackColor)
//
//        }
//        .padding(10)
//    }
    
    private func profileCard(_ profile: User) -> some View {
        HStack(spacing: 8) {
            AsyncImage(url: URL(string: profile.image)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                AppColor.borderColor
            }
            .frame(width: 54, height: 54)
            .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(profile.name)
                    .font(AppFont.regular.font(size: 15))
                    .foregroundStyle(AppColor.blackColor)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(profile.username)
                    .font(AppFont.regular.font(size: 13))
                    .foregroundStyle(AppColor.darkGrayColor)
            }
            Text("12:30 PM")
                .font(AppFont.regular.font(size: 11))
                .foregroundStyle(AppColor.darkGrayColor)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .onTapGesture {
            selectedChatProfile = nil
            selectedChatProfile = profile
            isActiveChatView = true
        }
    }
    
}

#Preview {
    MessagesView()
}
