//
//  CacheManager.swift
//  Fastiee
//
//  Created by Mu Yu on 6/25/22.
//

import Foundation

class CacheManager {
    
    // MARK: - Variables
    private let defaults = UserDefaults.standard
    static let shared = CacheManager()
    
    private let preferredLanguageKey = "preferredLanguage"
    
    private init() {
        
    }
}

extension CacheManager {
    var preferredLanguage: Language {
        get {
            if let value = defaults.string(forKey: preferredLanguageKey) {
                return Language(rawValue: value) ?? .en
            }
            return .en
        }
        set {
            defaults.set(newValue.rawValue, forKey: preferredLanguageKey)
        }
    }
    var preferredCurrency: String {
        return "USD"
    }
}

