//
//  MainTabView.swift
//  clothingclick
//
//  Created by DavidBisht on 21/04/26.
//

import SwiftUI

struct MainTabView: View {
    
    @State private var selectedTab: DashboardTab = .home
    @State private var goToNotifications = false
    
    init() {
        let appearance = UITabBarAppearance()
        
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        appearance.shadowColor = UIColor.lightGray   // line color
        appearance.shadowImage = UIImage()           // ensures line is visible
        
        UITabBar.appearance().standardAppearance = appearance
        
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
//            NavigationStack {
                HomePageView()
                    .navigationDestination(isPresented: $goToNotifications) {
                            NotificationsView()
                        }
//            }
//            .customNavigationBar(
//                config:NavBarConfig(
//                    title: Constants.AppName,
//                    font: AppFont.medium.font(size: 13.0),
//                    
//                    leading: NavBarItem(
//                        title: "Toronto",
//                        font: AppFont.medium.font(size: 13.0, relativeTo: .title),
//                        image: "headerlocation",
//                        isSystemImage: false,
//                        action: {
//                            print("location tapped")
//                        }
//                    ),
//                    
//                    trailing: [NavBarItem(
//                        title: "",
//                        font: AppFont.medium.font(size: 13.0, relativeTo: .title),
//                        image: "bell",
//                        isSystemImage: false,
//                        action: {
//                            print("notification tapped")
//                            goToNotifications = true
//                        }
//                    )]
//                )
//            )
            .tabItem { Image(.tabhome).renderingMode(.template); Text("Home"); }
                .tag(0)
            
            DiscoverView()
                .tabItem { Image(.tabdiscover).renderingMode(.template); Text("Discover"); }
                .tag(1)
            
            Text("Sell")
                .tabItem { Image(.tabsell).renderingMode(.template); Text("Sell"); }
                .tag(2)
            
            Text("Messages")
                .tabItem { Image(.tabmessages).renderingMode(.template); Text("Messages"); }
                .tag(3)
            
            Text("Account")
                .tabItem { Image(.tabaccount).renderingMode(.template); Text("Account"); }
                .tag(4)
        }
        .onAppear() {
            UITabBar.appearance().unselectedItemTintColor = UIColor(AppColor.grayTabColor)
            UITabBar.appearance().barTintColor = UIColor(AppColor.blackColor)
        }
        .tint(AppColor.blackColor)
    }
}

#Preview {
    MainTabView()
}
