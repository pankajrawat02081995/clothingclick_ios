//
//  NotificationsView.swift
//  clothingclick
//
//  Created by DavidBisht on 22/04/26.
//

import SwiftUI

struct NotificationsView: View {
    
    @State private var notifications = NotificationItem.sampleData
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(notifications) { item in
                    notificationRow(item)
                }
            }
            .padding(0)
        }
        .customNavigationBar(
            config: NavBarConfig(
                title: Constants.notifications,
                font: .system(size: 16, weight: .medium),
                leading: NavBarItem(
                    title: "",
                    font: .system(size: 14),
                    image: "back",
                    isSystemImage: false,
                    tint: .black,
                    action: {
                        dismiss()
                    }
                )
            )
        )
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
    }
    
    @ViewBuilder
    private func notificationRow(_ item: NotificationItem) -> some View {
        
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 12) {
                
                AsyncImage(url: URL(string: "")) { image in
                    image
                        .resizable()
                        .frame(width: 49, height: 49)
                        .background(AppColor.borderColor)
                        .clipShape(Circle())
                } placeholder: {
                    Image(item.image)
                        .resizable()
                        .frame(width: 49, height: 49)
                        .background(AppColor.borderColor)
                        .clipShape(Circle())
                }

                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(item.title)
                            .font(AppFont.medium.font(size: 15.0))
                            .foregroundStyle(AppColor.blackColor)
                        Spacer()
                        Text(item.time)
                            .font(AppFont.medium.font(size: 10.0))
                            .foregroundStyle(AppColor.grayTextColor)
                    }
                    if item.subtitle.isEmpty == false {
                        Text(item.subtitle)
                            .font(AppFont.regular.font(size: 13.0))
                            .foregroundStyle(AppColor.grayTextColor)
                    }
                    // Special Case: Follow Request Buttons
                    if item.type == .followRequest {
                        HStack {
                            Button(Constants.confirm) {}
                                .font(AppFont.medium.font(size: 10.0))
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .frame(height: 33)
                                .background(AppColor.blackColor)
                                .foregroundColor(AppColor.whiteColor)
                                .cornerRadius(5)
                            
                            Button(Constants.delete) {}
                                .font(AppFont.medium.font(size: 10.0))
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .frame(height: 33)
                                .background(AppColor.clearColor)
                                .foregroundColor(AppColor.blackColor)
                                .cornerRadius(5)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 5.0)
                                        .stroke(AppColor.grayTextColor, lineWidth: 1.0)
                                }
                        }
                        .padding(.top, 6)
                    }
                    
                    // Special Case: Price Drop
                    if item.type == .priceDrop {
                        Text("$45")
                            .font(AppFont.medium.font(size: 15.0))
                            .foregroundStyle(AppColor.redColor)
                    }
                }
            }
            .padding()
            CustomDivider(color: AppColor.borderColor, lineWidth: 1.0)
        }
    }
}

#Preview {
    NotificationsView()
}
