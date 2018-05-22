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
    func alertMessage() -> String
}

protocol ConsentKitDataSource {
    /// Returns if the item has a value of true
    func isAccepted (_ item: ConsentKitItem) -> Bool
    /// Returns if the item was reviewed and it has a value of either true or false
    func isReviewed (_ item: ConsentKitItem) -> Bool
    /// Set a value for the item
    func setAccepted (_ value: Bool, for item: ConsentKitItem)
    /// Resets the value of an item, which means that isReviewed will return false after that
    func reset (_ item: ConsentKitItem)
}

class ConsentKit {
    
    var dataSource: ConsentKitDataSource?
    
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
    
    /// Returns if there's any value that was not reviewed
    /// Used to check if the ConsentKitViewController should be presented or not
    /// This will also be useful to present the controller if any new service added later in the app needs reviewing
    func needsReviewing(_ items: [ConsentKitItem]) -> Bool {
        for item in items {
            if !isReviewed(item) {
                return true
            }
        }
        return false
    }
    
    /// This resets the built in UserDefaults values and does not affect custom dataSource
    func resetAll() {
        for (key, _) in list() {
            userDefaults.removeObject(forKey: key)
        }
        userDefaults.synchronize()
    }
    
    /// This lists the built in UserDefaults values
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

extension ConsentKit: ConsentKitDataSource {
    
    func isAccepted (_ item: ConsentKitItem) -> Bool {
        guard let dataSource = self.dataSource else {
            return (get(item.rawValue) as? Bool) == true
        }
        return dataSource.isAccepted(item)
    }

    func isReviewed (_ item: ConsentKitItem) -> Bool {
        guard let dataSource = self.dataSource else {
            return get(item.rawValue) != nil
        }
        return dataSource.isReviewed(item)
    }

    func setAccepted (_ value: Bool, for item: ConsentKitItem) {
        guard let dataSource = self.dataSource else {
            set(value, forKey: item.rawValue)
            return
        }
        dataSource.setAccepted(value, for: item)
    }
    
    func reset (_ item: ConsentKitItem) {
        guard let dataSource = self.dataSource else {
            set(nil, forKey: item.rawValue)
            return
        }
        dataSource.reset(item)
    }
}
