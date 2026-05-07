//
//  RootView.swift
//  clothingclick
//
//  Created by DavidBisht on 07/05/26.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        Group {
            switch appState.route {
            case .onboarding:
                LandingPageView()
            case .main:
                MainTabView()
            }
        }
        .id(appState.route) //resets all internal navigation stacks
        .animation(.easeInOut, value: appState.route)
    }
}

#Preview {
    RootView()
}
