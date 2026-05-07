//
//  clothingclickApp.swift
//  clothingclick
//
//  Created by DavidBisht on 20/04/26.
//

import SwiftUI

@main
struct clothingclickApp: App {
    
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
        }
    }
}
