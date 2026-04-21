//
//  MainTabView.swift
//  clothingclick
//
//  Created by DavidBisht on 21/04/26.
//

import SwiftUI

struct MainTabView: View {
    
    @State private var selectedTab: DashboardTab = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            HomePageView()
                .tabItem { Image(.tabhome); Text("Home"); }
                .tag(0)
            
            Text("Discover")
                .tabItem { Image(.tabdiscover); Text("Discover"); }
                .tag(1)
            
            Text("Sell")
                .tabItem { Image(.tabsell); Text("Sell"); }
                .tag(2)
            
            Text("Messages")
                .tabItem { Image(.tabmessages); Text("Messages"); }
                .tag(3)
            
            Text("Account")
                .tabItem { Image(.tabaccount); Text("Account"); }
                .tag(4)
        }
    }
}

#Preview {
    MainTabView()
}
