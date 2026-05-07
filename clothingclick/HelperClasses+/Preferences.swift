//
//  Preferences.swift
//  clothingclick
//
//  Created by DavidBisht on 06/05/26.
//

import Foundation

// MARK: - Keys
enum PreferenceIdentifier: String {
    case isOnboardingComplete
    case userName
    case userAge
    case isLoggedIn
}

// MARK: - Preferences Manager
final class Preferences {
    
    static let shared = Preferences()
    private let defaults = UserDefaults.standard
    
    private init() {}
    
    // MARK: - Generic SET
    func set<T>(_ value: T, for key: PreferenceIdentifier) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    // MARK: - Generic GET
    func get<T>(_ type: T.Type, for key: PreferenceIdentifier) -> T? {
        return defaults.object(forKey: key.rawValue) as? T
    }
    
    // MARK: - Bool (Convenience)
    func getBool(for key: PreferenceIdentifier) -> Bool {
        return defaults.bool(forKey: key.rawValue)
    }
    
    // MARK: - Remove
    func remove(for key: PreferenceIdentifier) {
        defaults.removeObject(forKey: key.rawValue)
    }
    
    // MARK: - Clear All
    func clearAll() {
        if let bundleID = Bundle.main.bundleIdentifier {
            defaults.removePersistentDomain(forName: bundleID)
        }
    }
    
}

extension Preferences {
    var isOnboardingComplete: Bool {
        get { defaults.bool(forKey: PreferenceIdentifier.isOnboardingComplete.rawValue) }
        set { defaults.set(newValue, forKey: PreferenceIdentifier.isOnboardingComplete.rawValue) }
    }
    
    var isLoggedIn: Bool {
        get { defaults.bool(forKey: PreferenceIdentifier.isLoggedIn.rawValue) }
        set { defaults.set(newValue, forKey: PreferenceIdentifier.isLoggedIn.rawValue) }
    }
}
