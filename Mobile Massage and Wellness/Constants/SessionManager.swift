//
//  SessionManager.swift
//  Mobile Massage and Wellness
//
//  Created by J.Sarath Krishnaswamy on 20/02/25.
//

import Foundation

import Foundation

class SessionManger {
    static let shared = SessionManger()
    private let defaults = UserDefaults.standard
    
    private init() {} // Prevent external initialization
    
    enum Keys: String {
        case userToken
        case username
        case isLoggedIn
    }
    
    // Save Value
    func save<T>(value: T, forKey key: Keys) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    // Retrieve Value
    func get<T>(forKey key: Keys) -> T? {
        return defaults.value(forKey: key.rawValue) as? T
    }
    
    // Remove Value
    func remove(forKey key: Keys) {
        defaults.removeObject(forKey: key.rawValue)
    }
    
    // Clear All UserDefaults
    func clearAll() {
        let domain = Bundle.main.bundleIdentifier!
        defaults.removePersistentDomain(forName: domain)
        defaults.synchronize()
    }
}
