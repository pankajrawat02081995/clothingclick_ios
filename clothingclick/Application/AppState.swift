//
//  AppState.swift
//  clothingclick
//
//  Created by DavidBisht on 07/05/26.
//

import Combine

enum AppRoute {
    case onboarding
    case main
}

final class AppState: ObservableObject {
    @Published var route: AppRoute = .onboarding

    init() {
        checkInitialState()
    }

    func checkInitialState() {
        let completed = Preferences.shared.isOnboardingComplete
        route = completed ? .main : .onboarding
    }

    func completeOnboarding() {
        Preferences.shared.isOnboardingComplete = true
        route = .main
    }
    
    func logout() {
        Preferences.shared.isLoggedIn = false
        Preferences.shared.isOnboardingComplete = false
        
        route = .onboarding
    }
    
    func login() {
        Preferences.shared.isLoggedIn = true
        route = .main
    }
}
