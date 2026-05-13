//
//  Environment+Extensions.swift
//  clothingclick
//
//  Created by DavidBisht on 13/05/26.
//

import SwiftUI

// MARK: - Sheet Toggle Environment Key
struct ShowSheetKey: EnvironmentKey {
    // The default value is an empty closure so the app doesn't crash
    // if you forget to provide an action in a Preview.
    static let defaultValue: (Bool) -> Void = { _ in }
}

extension EnvironmentValues {
    /// Use this to toggle the main bottom sheet from any view.
    /// Usage: @Environment(\.toggleMainSheet) var toggleMainSheet
    var toggleMainSheet: (Bool) -> Void {
        get { self[ShowSheetKey.self] }
        set { self[ShowSheetKey.self] = newValue }
    }
}
