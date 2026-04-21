//
//  Router.swift
//  clothingclick
//
//  Created by DavidBisht on 20/04/26.
//

import SwiftUI
import Combine

final class Router: ObservableObject {
    
    @Published var navPath: NavigationPath = NavigationPath()
    
    enum AuthFlow: Hashable, Codable {
        case home
        case discover
        case sell
        case messages
        case account
    }
    
    func navigate(to destination: AuthFlow) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
    
}
