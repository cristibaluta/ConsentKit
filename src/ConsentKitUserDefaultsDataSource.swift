//
//  ConsentKitUserDefaultsDataSource.swift
//
//  Created by Cristian Baluta on 23/05/2018.
//  Copyright © 2018 Imagin soft. All rights reserved.
//

import Foundation

class ConsentKitUserDefaultsDataSource {
    
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

extension ConsentKitUserDefaultsDataSource: ConsentKitDataSource {
    
    func isAccepted (_ item: ConsentKitItem) -> Bool {
        return (get(item.rawValue) as? Bool) == true
    }
    
    func isReviewed (_ item: ConsentKitItem) -> Bool {
        return get(item.rawValue) != nil
    }
    
    func setAccepted (_ value: Bool, for item: ConsentKitItem) {
        set(value, forKey: item.rawValue)
    }
    
    func reset (_ item: ConsentKitItem) {
        set(nil, forKey: item.rawValue)
    }
}
