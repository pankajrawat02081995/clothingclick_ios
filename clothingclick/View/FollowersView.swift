//
//  FollowersView.swift
//  clothingclick
//
//  Created by DavidBisht on 26/04/26.
//

import SwiftUI

struct FollowersView: View {
    
    @StateObject var vm = FollowersViewModel()
    @Environment(\.dismiss) var dismiss
    let profile: User
    
    var body: some View {
        VStack {
            
            CustomTabBarView(
                tabs: FollowStatus.allCases,
                selectedTab: vm.selectedTab,
                title: { $0.title + "(236)"}
            ) { tab in
                vm.selectedTab = tab
            }
            
            HStack{
                TextField(Constants.searchProfiles, text: $vm.search)
                    .submitLabel(.done)
                    .onSubmit {
                        vm.searchUser()
                    }
                Image(.search)
                    .onTapGesture {
                        vm.searchUser()
                    }
            }
            .padding()
            .background(AppColor.lightGrayColor)
                .padding()
            
            ScrollView {
                VStack(spacing: 12) {
                    if vm.search.isEmpty {
                        ForEach(vm.users) { user in
                            UserRowView(user: user) {
                                vm.toggleFollow(user)
                            }
                            .padding(.horizontal)
                            CustomDivider(color: AppColor.borderColor, lineWidth: 1)
                        }
                    } else {
                        ForEach(vm.filterUsers) { user in
                            UserRowView(user: user) {
                                vm.toggleFollow(user)
                            }
                            .padding(.horizontal)
                            CustomDivider(color: AppColor.borderColor, lineWidth: 1)
                        }
                    }
                }
               
            }
        }
        .customNavigationBar(
            config:NavBarConfig(
                title: profile.name,
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
                trailing: []
            )
        )

    }
}

#Preview {
    FollowersView(profile: User(name: "Aman", username: "aman34", followers: 285, isFollowing: true, image: ""))
}
