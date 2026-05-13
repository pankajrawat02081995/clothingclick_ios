//
//  MainTabView.swift
//  clothingclick
//
//  Created by DavidBisht on 21/04/26.
//

import SwiftUI

struct MainTabView: View {
    
    @State private var selectedTab: DashboardTab = .home
    @State private var showSheet = false
    
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
                NavigationStack {
                    HomePageView()
                }
                .tabItem { Image(.tabhome).renderingMode(.template); Text(Constants.home); }
                .tag(DashboardTab.home)
                
                NavigationStack {
                    DiscoverView()
                }
                .tabItem { Image(.tabdiscover).renderingMode(.template); Text(Constants.discover); }
                .tag(DashboardTab.discover)
                
                NavigationStack {
                    SellView()
                }
                    .tabItem { Image(.tabsell).renderingMode(.template); Text(Constants.sell); }
                    .tag(DashboardTab.sell)
                NavigationStack {
                    MessagesView()
                }
                    .tabItem { Image(.tabmessages).renderingMode(.template); Text(Constants.messages); }
                    .tag(DashboardTab.messages)
                
                NavigationStack {
                    AccountView()
                }
                    .tabItem { Image(.tabaccount).renderingMode(.template); Text(Constants.account); }
                    .tag(DashboardTab.account)
            }
            .onAppear() {
                UITabBar.appearance().unselectedItemTintColor = UIColor(AppColor.grayTabColor)
                UITabBar.appearance().barTintColor = UIColor(AppColor.blackColor)
            }
            .tint(AppColor.blackColor)
            .fullScreenCover(isPresented: $showSheet) {
                NavigationStack {
                    SignUpPopupView()
                }
                    .presentationBackground(.clear)
                    
            }
        
        // This links the environment key to your local @State
            .environment(\.toggleMainSheet) { value in
                showSheet = value
            }
    }
    
}

#Preview {
    MainTabView()
}
