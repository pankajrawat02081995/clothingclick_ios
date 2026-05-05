//
//  EnableSwipeBack.swift
//  clothingclick
//
//  Created by DavidBisht on 02/05/26.
//

import SwiftUI

extension View {
    func enableSwipeBack() {
        // Access the window scene and navigation controller
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let navigationController = window.rootViewController?.navigationController ??
                findNavigationController(in: window.rootViewController) else {
            return
        }
        // Enable the interactive pop gesture recognizer
        navigationController.interactivePopGestureRecognizer?.isEnabled = true
        
        // Remove the delegate to prevent blocking
        navigationController.interactivePopGestureRecognizer?.delegate = nil
    }
    
    private func findNavigationController(in viewController: UIViewController?) -> UINavigationController? {
        guard let viewController = viewController else {
            return nil
        }

        if let navigationController = viewController as? UINavigationController {
            return navigationController
        }

        for child in viewController.children {
            if let found = findNavigationController(in: child) {
                return found
            }
        }

        return nil
    }
}
