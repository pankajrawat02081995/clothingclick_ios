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
    @State private var goToSelectLocation = false
    @State private var navigationBarVisibility: Visibility = .visible
    @State private var location: String = ""
    
    var leadingTitle: String {
        if selectedTab == .discover {
            return ""
        }
        return location.isEmpty ? Constants.selectLocation : location
    }
    
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
        NavigationStack {
            TabView(selection: $selectedTab) {
                HomePageView()
                    .navigationDestination(isPresented: $goToNotifications) {
                        NotificationsView()
                    }
                    .navigationDestination(isPresented: $goToSelectLocation) {
                        LocationView()
                    }
                    .tabItem { Image(.tabhome).renderingMode(.template); Text(Constants.home); }
                    .tag(DashboardTab.home)
                
                DiscoverView()
                    .tabItem { Image(.tabdiscover).renderingMode(.template); Text(Constants.discover); }
                    .tag(DashboardTab.discover)
                
                Text(Constants.sell)
                    .tabItem { Image(.tabsell).renderingMode(.template); Text(Constants.sell); }
                    .tag(DashboardTab.sell)
                
                Text(Constants.messages)
                    .tabItem { Image(.tabmessages).renderingMode(.template); Text(Constants.messages); }
                    .tag(DashboardTab.messages)
                
                Text(Constants.account)
                    .tabItem { Image(.tabaccount).renderingMode(.template); Text(Constants.account); }
                    .tag(DashboardTab.account)
            }
            .onAppear() {
                UITabBar.appearance().unselectedItemTintColor = UIColor(AppColor.grayTabColor)
                UITabBar.appearance().barTintColor = UIColor(AppColor.blackColor)
            }
            .tint(AppColor.blackColor)
            .onChange(of: selectedTab) { _, newValue in
                switch newValue {
                case .home, .discover:
                    navigationBarVisibility = .visible
                case .sell, .messages, .account:
                    navigationBarVisibility = .hidden
                }
            }
        }
        .customNavigationBar(
            config:NavBarConfig(
                title: Constants.AppName,
                font: AppFont.medium.font(size: 13.0),
                
                leading: NavBarItem(
                    title: leadingTitle,
                    font: AppFont.medium.font(size: 13.0, relativeTo: .title),
                    image: "headerlocation",
                    isSystemImage: false,
                    action: {
                        switch selectedTab {
                        case .home:
                            goToSelectLocation = true
                        case .discover:
                            break;
                        case .sell:
                            break;
                        case .messages:
                            break;
                        case .account:
                            break;
                        }
                    }
                ),
                
                trailing: [NavBarItem(
                    title: "",
                    font: AppFont.medium.font(size: 13.0, relativeTo: .title),
                    image: "bell",
                    isSystemImage: false,
                    action: {
                        print("notification tapped")
                        goToNotifications = true
                    }
                )]
            )
        )
        .toolbar(navigationBarVisibility, for: .navigationBar)
    }
    
}

#Preview {
    MainTabView()
}
