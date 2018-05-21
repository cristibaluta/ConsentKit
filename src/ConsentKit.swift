//
//  Consent.swift
//
//  Created by Cristian Baluta on 21/05/2018.
//  Copyright © 2018 Imagin soft. All rights reserved.
//

import Foundation

protocol ConsentKitItem {
    var rawValue: String {get}
    func title() -> String
    func description() -> String
    func alertDescription() -> String
    static var allValues: [ConsentKitItem] {get}
}

class ConsentKit {
    
    fileprivate let prefix = "ConsentKit-"
    fileprivate let userDefaults = UserDefaults.standard
    
    fileprivate func get (_ key: String) -> Any? {
        return userDefaults.object(forKey: prefix + key)
    }
    
    fileprivate func set (_ value: Bool?, forKey key: String) {
        if let v = value {
            userDefaults.set(v, forKey: prefix + key)
        } else {
            userDefaults.removeObject(forKey: prefix + key)
        }
        userDefaults.synchronize()
    }
}

extension ConsentKit {
    
    /// Returns if the item has a value of true
    func isAccepted (_ key: ConsentKitItem) -> Bool {
        return (get(key.rawValue) as? Bool) == true
    }

    /// Returns if the item was reviewed
    func isReviewed (_ key: ConsentKitItem) -> Bool {
        return get(key.rawValue) != nil
    }

    /// Returns if there's any value that was not reviewed
    /// Used to check if the ConsentKitViewController should be presented or not
    /// This will also be useful to present the controller if any new service added later in the app needs reviewing
    func needsReviewing(_ keys: [ConsentKitItem]) -> Bool {
        for key in keys {
            if get(key.rawValue) == nil {
                return true
            }
        }
        return false
    }
    
    func set (_ value: Bool, for key: ConsentKitItem) {
        set(value, forKey: key.rawValue)
    }
    
    func reset (_ key: ConsentKitItem) {
        set(nil, forKey: key.rawValue)
    }
    
    func resetAll() {
        for (key, _) in list() {
            userDefaults.removeObject(forKey: key)
        }
        userDefaults.synchronize()
    }
    
    func list() -> [String: Any] {
        let allDefaults = userDefaults.dictionaryRepresentation()
        var myDefaults = [String: Any]()
        for (key, value) in allDefaults {
            if key.hasPrefix(prefix) {
                myDefaults[key] = value
            }
        }
        return myDefaults
    }
}
